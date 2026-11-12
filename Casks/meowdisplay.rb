cask "meowdisplay" do
  version "2.1.0"
  sha256 "d02273969b8a00fc7269f69ab6440bae92028bcb55b9e5f4765cb5d925e8c316"

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
