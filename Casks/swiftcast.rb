# Template for Casks/swiftcast.rb in inhzus/homebrew-tap. The release workflow fills in
# version and sha256 and pushes it there.
cask "swiftcast" do
  version "0.4.0"
  sha256 "f1bd0b79c592071b3dabbf90da6963d5be5e9f60161ead0d668b4d0d7b44ec55"

  url "https://github.com/inhzus/swiftcast/releases/download/v#{version}/SwiftCast-#{version}.zip"
  name "SwiftCast"
  desc "Fast, native app launcher"
  homepage "https://github.com/inhzus/swiftcast"

  depends_on macos: :tahoe

  app "SwiftCast.app"

  # Builds are ad-hoc signed, not notarized, so Gatekeeper would block the first launch.
  # Remove this once releases are notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/SwiftCast.app"],
        writable_paths: ["{{appdir}}/SwiftCast.app"]
  end

  uninstall quit: "dev.swiftcast.app"

  zap trash: "~/Library/Preferences/dev.swiftcast.app.plist"
end
