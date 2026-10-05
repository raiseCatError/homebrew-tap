class Nmsh < Formula
  desc "Terminal frontend for your real zsh, Bash or Fish shell"
  homepage "https://github.com/raiseCatError/notMyShell"
  url "https://github.com/raiseCatError/notMyShell/archive/refs/tags/v0.17.0.tar.gz"
  sha256 "037d4faa263649d7e804aae02c80531d29e253f25f23198e0b8d322b2beb8715"
  license "GPL-3.0-only"

  depends_on "python" => :build
  depends_on "node"

  def fetch
    system "npm", "ci", *std_npm_args(prefix: false)
  end

  def install
    # Reviewed node-pty lifecycle builds the addon; NMSh's postinstall fixes
    # spawn-helper permissions. Homebrew's helper retains its cache/cooldown policy.
    ENV["npm_config_nodedir"] = formula_opt_prefix("node")
    system "npm", "ci", *std_npm_args(prefix: false, ignore_scripts: false), "--offline"
    system "npm", "run", "build"
    system "npm", "prune", "--omit=dev", "--offline", "--ignore-scripts"

    libexec.install "bin", "dist", "node_modules", "package.json", "LICENSE"
    (libexec/"scripts").install "scripts/read-command-history.cjs", "scripts/ensure-node-pty-helper.mjs"
    (libexec/"assets").install "assets/completion", "assets/understanding"
    (libexec/"assets/brand").install "assets/brand/nmsh-logo.png"
    (bin/"nmsh").write_env_script libexec/"bin/nmsh", PATH: "#{formula_opt_bin("node")}:$PATH"
  end

  test do
    assert_match "notMyShell #{version}", shell_output("#{bin}/nmsh --version")
    (testpath/"native.cjs").write <<~JS
      const assert = require("node:assert/strict");
      const pty = require("#{libexec}/node_modules/node-pty");
      const term = pty.spawn("/bin/echo", ["nmsh-pty-ok"], {cols: 80, rows: 24});
      let output = "";
      const timeout = setTimeout(() => { term.kill(); process.exit(1); }, 5000);
      term.onData(data => { output += data; });
      term.onExit(({exitCode}) => {
        clearTimeout(timeout);
        assert.equal(exitCode, 0);
        assert.match(output, /nmsh-pty-ok/);
        console.log("nmsh-pty-ok");
      });
    JS
    assert_match "nmsh-pty-ok", shell_output("#{formula_opt_bin("node")}/node #{testpath}/native.cjs")
    (testpath/"updater.mjs").write <<~JS
      import assert from "node:assert/strict";
      import {detectInstall, planUpdate} from "#{libexec}/dist/update/update.js";
      const runner = {run: async () => { throw new Error("Homebrew update must not run a command"); }};
      const install = await detectInstall("#{libexec}", runner);
      assert.equal(install.kind, "homebrew");
      const plan = await planUpdate(install, {tag: "v99.0.0", version: "99.0.0", url: "", summary: []}, runner);
      assert.equal(plan.ok, false);
      assert.match(plan.manual.join(" "), /brew upgrade/);
      console.log("homebrew-update-guard-ok");
    JS
    assert_match "homebrew-update-guard-ok", shell_output("#{formula_opt_bin("node")}/node #{testpath}/updater.mjs")
  end
end
