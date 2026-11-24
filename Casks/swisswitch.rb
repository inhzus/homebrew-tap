# Template for Casks/swisswitch.rb in inhzus/homebrew-tap. The release workflow fills in
# version and sha256 and pushes it there.
cask "swisswitch" do
  version "0.1.2"
  sha256 "a780be5587187c6986301194ff26a0d57059ada7edba2aa0dc77e08ec86f8eb7"

  url "https://github.com/inhzus/swisswitch/releases/download/v#{version}/Swisswitch-#{version}.zip"
  name "Swisswitch"
  desc "Switch apps with Right Command + a letter"
  homepage "https://github.com/inhzus/swisswitch"

  depends_on macos: :golden_gate

  app "Swisswitch.app"

  # Builds are not notarized, so Gatekeeper would block the first launch.
  # Remove this once releases are notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Swisswitch.app"],
        writable_paths: ["{{appdir}}/Swisswitch.app"]
  end

  uninstall quit: "io.zunish.Swisswitch"

  zap trash: [
    "~/Library/Application Support/swisswitch",
    "~/Library/Preferences/io.zunish.Swisswitch.plist",
  ]

  caveats <<~EOS
    Swisswitch needs Accessibility access to see the Right Command key:
      System Settings → Privacy & Security → Accessibility
  EOS
end
