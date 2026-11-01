cask "meowdisplay" do
  version "1.20.0"
  sha256 "ab684d6bf4252e9f92c7d1a9b49a46550fefac9377af30253b808bed9be4202c"

  url "https://github.com/raiseCatError/meowdisplay/releases/download/v#{version}/MeowDisplay.dmg",
      verified: "github.com/raiseCatError/meowdisplay/"
  name "MeowDisplay"
  desc "Mirror or extend the screen onto an iPhone, iPad or second computer"
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
