# ZitronenCitrat Homebrew Tap

Homebrew cask for [ClaudeDesktopCompanion](https://github.com/ZitronenCitrat/ClaudeDesktopCompanion) —
a macOS menu bar companion that shows what Claude Code is doing.

## Install

```bash
brew tap zitronencitrat/tap
brew install --cask claude-desktop-companion
```

Requires macOS 26+. The app is not notarized; on first launch right-click ▸ Open,
or run once: `xattr -dr com.apple.quarantine "/Applications/ClaudeDesktopCompanion.app"`.
