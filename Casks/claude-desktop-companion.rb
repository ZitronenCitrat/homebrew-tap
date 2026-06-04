cask "claude-desktop-companion" do
  version "1.0"
  sha256 "723aa8bfd7f20bef3fcd019c5b759a0ef0342c512c7962a5170e6de63ff357d4"

  url "https://github.com/ZitronenCitrat/ClaudeDesktopCompanion/releases/download/v#{version}/ClaudeDesktopCompanion-#{version}.zip"
  name "Claude Desktop Companion"
  desc "Menu bar companion showing Claude Code session state"
  homepage "https://github.com/ZitronenCitrat/ClaudeDesktopCompanion"

  app "ClaudeDesktopCompanion.app"

  caveats <<~EOS
    Requires macOS 26 or newer.

    This app is not notarized with an Apple Developer account, so macOS
    Gatekeeper may refuse to open it the first time. Clear the quarantine flag
    once:

      xattr -dr com.apple.quarantine "#{appdir}/ClaudeDesktopCompanion.app"

    Then open the app and finish setup in Einstellungen ▸ Hooks.
  EOS
end
