# ZitronenCitrat Homebrew Tap

Personal macOS apps, installable with [Homebrew](https://brew.sh).

📊 **[Tap Insights](https://zitronencitrat.github.io/homebrew-tap/)**: downloads per app and version, updated daily.

```bash
brew tap zitronencitrat/tap
brew trust zitronencitrat/tap   # Homebrew 7.0.11+ only loads casks from taps you trust
```

| Cask | App | macOS |
|---|---|---|
| [`pokedex-portfolio`](#pokédex-portfolio) | **Pokédex Portfolio**: Pokémon TCG collection manager with Pokédex, EN/DE/JA card catalog and Cardmarket prices | 27+, Apple Silicon |
| [`planner`](#planner) | **Planner**: a personal planner for student life: calendar, tasks, studies, habits, goals and subscriptions | 27+ |
| [`claude-desktop-companion`](#claude-desktop-companion) | **[ClaudeDesktopCompanion](https://github.com/ZitronenCitrat/ClaudeDesktopCompanion)**: menu bar companion that shows what Claude Code is doing | 26+ |

> All apps are ad-hoc signed and **not notarized** (no Apple Developer account). Where the cask does not do it for you, clear the quarantine flag once after installing, see each app below.

---

## Pokédex Portfolio

Native macOS app for Pokémon TCG collectors: full Pokédex, card catalog in English, German and Japanese, collections and wishlist, and card prices that always show source, currency and date. Runs locally, no account, no API keys, no tracking.

```bash
brew install --cask zitronencitrat/tap/pokedex-portfolio
```

- **No Gatekeeper step needed:** the cask clears the quarantine flag itself.
- **Your collection is backed up automatically:** on the first launch of every new version the app copies it to its own container (`…/Application Support/de.felixfischer.PokedexPortfolioDesktop/Backups/`, newest 10) before anything is migrated.
- First launch downloads the card catalog (~20 MB) and the Pokédex (~2 MB).

| Task | Command |
|---|---|
| Update | `brew update && brew upgrade --cask pokedex-portfolio` |
| Uninstall, keep the collection | `brew uninstall --cask pokedex-portfolio` |
| Uninstall and delete all data | `brew uninstall --zap --cask pokedex-portfolio` ⚠️ deletes the collection |

App zips are attached to the [`pokedex-portfolio-v*` releases](https://github.com/ZitronenCitrat/homebrew-tap/releases) of this repo.

<sub>Unofficial fan project, not affiliated with Nintendo, Creatures, GAME FREAK or The Pokémon Company. Card data and images are loaded at runtime from TCGdex, PokéAPI and TCGCSV; none are bundled.</sub>

## Planner

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

## Claude Desktop Companion

```bash
brew install --cask zitronencitrat/tap/claude-desktop-companion
xattr -dr com.apple.quarantine "/Applications/ClaudeDesktopCompanion.app"
```

Then open the app and finish setup in Einstellungen ▸ Hooks.

---

## For me: Tap Insights

[`.github/workflows/dashboard.yml`](.github/workflows/dashboard.yml) runs daily (and on pushes to `Casks/` or `dashboard/`). It reads the download count of every cask's release assets ([`dashboard/collect.py`](dashboard/collect.py); new casks are picked up from their `url` automatically), appends a snapshot to `downloads.json` on the `stats` branch and deploys [`dashboard/index.html`](dashboard/index.html) to GitHub Pages. Run it by hand: Actions ▸ Dashboard ▸ Run workflow.

Homebrew has no install analytics for third-party taps, so the numbers are GitHub release downloads: installs + updates (+ manual downloads), not unique users. GitHub pauses scheduled workflows after 60 days without repository activity; re-enable it in the Actions tab if the page stops updating.

## For me: publishing a release

| App | How |
|---|---|
| Pokédex Portfolio | Bump `MARKETING_VERSION`, commit, run `scripts/release.sh` in the app repo (builds, uploads the zip, bumps the cask, pushes) |
| Planner | Automatic: its own pipeline builds, uploads the zip and bumps the cask |
| Claude Desktop Companion | Upload the zip to a release in its repo, update `version` and `sha256` in the cask (`shasum -a 256 <zip>`) |
