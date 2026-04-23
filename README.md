# lb-tui – ListenBrainz TUI player
A terminal‑based music player that streams from YouTube and syncs your listening activity with **[ListenBrainz](https://listenbrainz.org)**.
- 🎧 Browse your **liked tracks**, **weekly jams**, and **weekly exploration** playlists  
- 🔎 Search YouTube and pick from results inside the TUI  
- 📋 Browse your personal playlists  
- 🔍 Filter any track list in real‑time  
- 🎮 Vim‑friendly keybindings (`j`/`k`, `/`, `:`)  
- 📡 Automatic **scrobbling** and “now playing” status  
---
## Quick Start (Nix)
```bash
git clone https://github.com/mobsenpai/listenbrainz_player
cd listenbrainz_player
nix develop
lb
```

The TUI opens immediately. The **Liked** tab loads automatically.

---

## Without Nix

Requirements: `mpv` and `yt-dlp` must be installed on your system.

```bash
pip install .
lb
```

---

## Environment Variables

Create a `.env` file in the project root:

```env

LISTENBRAINZ_TOKEN=your_api_token_here
LB_USERNAME=your_listenbrainz_username
```
You can get your API token from your **[ListenBrainz profile](https://listenbrainz.org/profile/)** → “User token”.

---

## Controls

### Tabs

| Key | Tab                | Loads                               |
| --- | ------------------ | ----------------------------------- |
| `1` | **Liked**          | Your loved tracks                   |
| `2` | **Weekly Jams**    | This week’s jams                    |
| `3` | **Weekly Explor.** | Weekly exploration playlist         |
| `4` | **Search**         | Search YouTube (type query + Enter) |
| `5` | **Playlist**       | Browse your ListenBrainz playlists  |

### Global keybindings

|Key|Action|
|---|---|
|`j` / `↓`|Move down|
|`k` / `↑`|Move up|
|`Enter`|Play selected track|
|`p` / `Space`|Pause / resume|
|`n`|Next track|
|`b`|Previous track|
|`s`|Toggle shuffle|
|`/`|**Filter** current playlist (Search tab: new query)|
|`:`|Command prompt (`:play`, `:liked`, etc.)|
|`q`|Quit|

### Filter

- Press `/` and type a search term, then `Enter`.  
    The track list is narrowed down instantly.
    
- To **clear** the filter, press `/` + `Enter` (empty query) or type `:filter`.
    

### Commands (`:`)

|Command|Action|
|---|---|
|`:play <query>`|Instantly play the first YouTube result|
|`:liked`|Load liked tracks|
|`:weekly`|Load weekly jams|
|`:weeklyexpl`|Load weekly exploration|
|`:playlist <mbid>`|Load a specific playlist|
|`:clear`|Clear queue and stop playback|
|`:pause` / `:stop`|Pause|
|`:next` / `:prev`|Next / previous track|
|`:shuffle`|Toggle shuffle|
|`:quit`|Quit|

---

## Scrobbling

- **Now playing** is sent as soon as a track starts.
    
- **Scrobbling** happens only after the track has been listened to for at least **30 seconds** (configurable via `SCROBBLE_THRESHOLD` in `config.py`).
    
- The “now playing” status is cleared immediately when you quit.
