cask "meowdisplay" do
  version "2.0.0"
  sha256 "9b9fb406774d40ca737d74fb597d9dd8eaf7b3877d6bc4e6d294fff7d239bae7"

  url "https://github.com/raiseCatError/meowdisplay/releases/download/v#{version}/MeowDisplay.dmg"
  name "MeowDisplay"
  desc "Mirror, extend and control your desktop from phones, tablets and computers"
  homepage "https://meowdisplay.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "MeowDisplay.app"

  uninstall quit: "com.raisecaterror.meowdisplay.mac"

  zap trash: [
    "~/Library/Caches/com.raisecaterror.meowdisplay.mac",
    "~/Library/HTTPStorages/com.raisecaterror.meowdisplay.mac",
    "~/Library/Preferences/com.raisecaterror.meowdisplay.mac.plist",
    "~/Library/Saved Application State/com.raisecaterror.meowdisplay.mac.savedState",
  ]
end
