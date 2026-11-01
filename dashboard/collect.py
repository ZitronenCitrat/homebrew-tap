#!/usr/bin/env python3
"""Snapshot GitHub release download counts for every cask in this tap.

Homebrew publishes no install analytics for third-party taps, but every `brew install`/`upgrade`
downloads the cask's release asset from GitHub, which counts it. So asset downloads ~ installs + updates.

Casks are discovered from Casks/*.rb (their `url` must point at a GitHub release download), so a new
cask shows up without touching this file.

  python3 dashboard/collect.py <history.json>   # updates the file in place, one entry per UTC day
"""
import datetime
import json
import os
import pathlib
import re
import sys
import urllib.request

TAP = pathlib.Path(__file__).resolve().parent.parent
URL = re.compile(r'url "https://github\.com/([^/]+/[^/]+)/releases/download/([^"#]*)#\{version\}')
NAME = re.compile(r'^\s*name "([^"]+)"', re.M)


def api(path):
    request = urllib.request.Request(f"https://api.github.com/{path}", headers={"Accept": "application/vnd.github+json"})
    if token := os.environ.get("GITHUB_TOKEN"):
        request.add_header("Authorization", f"Bearer {token}")
    with urllib.request.urlopen(request, timeout=30) as response:
        return json.load(response)


def releases(repo, cache={}):
    if repo not in cache:
        cache[repo], page = [], 1
        while batch := api(f"repos/{repo}/releases?per_page=100&page={page}"):
            cache[repo] += batch
            page += 1
    return cache[repo]


def casks():
    for path in sorted(TAP.glob("Casks/*.rb")):
        source = path.read_text()
        url = URL.search(source)
        if not url:
            continue  # not hosted on GitHub releases: nothing to count
        repo, prefix = url.groups()
        name = NAME.search(source)
        versions = [
            {
                "version": release["tag_name"][len(prefix):],
                "published": release["published_at"],
                "downloads": sum(asset["download_count"] for asset in release["assets"]),
            }
            for release in releases(repo)
            if release["tag_name"].startswith(prefix) and not release["draft"]
        ]
        versions.sort(key=lambda v: v["published"] or "")
        yield {
            "token": path.stem,
            "name": name.group(1) if name else path.stem,
            "repo": repo,
            "versions": versions,
            "total": sum(v["downloads"] for v in versions),
        }


def main(history_path):
    path = pathlib.Path(history_path)
    data = json.loads(path.read_text()) if path.exists() else {"history": []}
    now = datetime.datetime.now(datetime.timezone.utc)
    today = now.date().isoformat()
    data["casks"] = list(casks())
    data["updated"] = now.isoformat(timespec="seconds")
    # One snapshot per day; a re-run the same day replaces it.
    data["history"] = [h for h in data["history"] if h["date"] != today]
    data["history"].append({"date": today, "totals": {c["token"]: c["total"] for c in data["casks"]}})
    data["history"].sort(key=lambda h: h["date"])
    path.write_text(json.dumps(data, indent=1, ensure_ascii=False) + "\n")
    print(f"{today}: " + ", ".join(f'{c["token"]}={c["total"]}' for c in data["casks"]))


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "downloads.json")
