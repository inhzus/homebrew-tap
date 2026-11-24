# Template for Casks/swisswitch.rb in inhzus/homebrew-tap. The release workflow fills in
# version and sha256 and pushes it there.
cask "swisswitch" do
  version "0.1.0"
  sha256 "f4109c01b6a8a512473cb60f66262c65f0c55388a4964ba5db47182554aab20d"

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
