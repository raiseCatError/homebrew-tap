cask "meowdisplay-receiver" do
  version "1.20.0"
  sha256 "d66b751794d7aad01904a6cab596ae2aa0bf3a328adead57be3e56cb96651fe1"

  url "https://github.com/raiseCatError/meowdisplay/releases/download/v#{version}/MeowDisplayReceiver.dmg"
  name "MeowDisplay Receiver"
  desc "Receiver that turns a spare computer into a MeowDisplay screen"
  homepage "https://meowdisplay.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "MeowDisplay Receiver.app"

  uninstall quit: "com.raisecaterror.meowdisplay.mac.receiver"

  zap trash: [
    "~/Library/Caches/com.raisecaterror.meowdisplay.mac.receiver",
    "~/Library/HTTPStorages/com.raisecaterror.meowdisplay.mac.receiver",
    "~/Library/Preferences/com.raisecaterror.meowdisplay.mac.receiver.plist",
    "~/Library/Saved Application State/com.raisecaterror.meowdisplay.mac.receiver.savedState",
  ]
end
