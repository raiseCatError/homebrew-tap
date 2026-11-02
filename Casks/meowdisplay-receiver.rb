cask "meowdisplay-receiver" do
  version "2.0.0"
  sha256 "3860b8941aa48e8f48b59f7252be8fe742c6bbd01c22b067a5861cb847581d98"

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
