cask "meowdisplay-receiver" do
  version "2.1.0"
  sha256 "4981863429e85dacf916287e466867ff1c38c838bc364c0ae483739b8d17eaf7"

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
