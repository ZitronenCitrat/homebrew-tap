# ZitronenCitrat Homebrew Tap

| Cask | App |
|---|---|
| `claude-desktop-companion` | [ClaudeDesktopCompanion](https://github.com/ZitronenCitrat/ClaudeDesktopCompanion) — menu bar companion that shows what Claude Code is doing |
| `planner` | Planner — personal planner for calendar, tasks, studies, habits and subscriptions (macOS 27+) |

## Install

```bash
brew tap zitronencitrat/tap
brew install --cask claude-desktop-companion
```

Requires macOS 26+. The app is not notarized; on first launch right-click ▸ Open,
or run once: `xattr -dr com.apple.quarantine "/Applications/ClaudeDesktopCompanion.app"`.

### Planner

```bash
brew install --cask zitronencitrat/tap/planner
xattr -dr com.apple.quarantine "/Applications/Planner.app"
```

The app zip is attached to the [`planner-v*` releases](https://github.com/ZitronenCitrat/homebrew-tap/releases) of this repo.
