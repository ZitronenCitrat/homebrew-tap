# ZitronenCitrat Homebrew Tap

| Cask | App |
|---|---|
| `claude-desktop-companion` | [ClaudeDesktopCompanion](https://github.com/ZitronenCitrat/ClaudeDesktopCompanion) — menu bar companion that shows what Claude Code is doing |
| `planner` | Planner — a personal planner for student life: calendar, tasks, studies, habits, goals and subscriptions (macOS 27+) |

## Install

```bash
brew tap zitronencitrat/tap
brew install --cask claude-desktop-companion
```

Requires macOS 26+. The app is not notarized; on first launch right-click ▸ Open,
or run once: `xattr -dr com.apple.quarantine "/Applications/ClaudeDesktopCompanion.app"`.

### Planner

A native SwiftUI app for macOS 27 that keeps everything in one place:

- **Today** — the day's events and everything that is due.
- **Calendar** — 3-day, work week, week and month views; drag open tasks into the calendar to plan time for them.
- **Tasks** — lists like Reminders: Today, Scheduled, All, Done, plus projects, priorities and estimates.
- **Studies** — modules with credits, grades and attempts; semesters with lecture periods and holidays. Lectures repeat weekly or every two weeks and show up in the calendar by themselves.
- **Habits** — a weekly target with tolerance, or daily.
- **Goals** — progress from linked tasks.
- **Subscriptions** — monthly and yearly cost as a treemap, next payment and cancellation deadline.
- **Groups** — your own names and colours across events, habits, goals, projects and tasks, with filters and collapsible sections.

```bash
brew install --cask zitronencitrat/tap/planner
xattr -dr com.apple.quarantine "/Applications/Planner.app"
```

A Planner account is required (invite only). Update with `brew upgrade --cask planner`;
macOS then asks once whether Planner may use its saved login — choose "Always Allow".

New versions are built and published automatically: the app zip is attached to the
[`planner-v*` releases](https://github.com/ZitronenCitrat/homebrew-tap/releases) of this repo,
and the cask is updated in the same run.
