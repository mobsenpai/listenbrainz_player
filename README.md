# listenbrainz_player

A CLI/TUI music player that streams from YouTube and syncs with ListenBrainz.

## Features

- 🎵 Play any song by searching YouTube: `lb play "Artist Song"`
- 📡 Scrobble listens and "now playing" to ListenBrainz automatically
- ❤️ Play your liked tracks: `lb liked`
- 📅 Play your weekly jams: `lb weekly`
- 🖥️ Interactive TUI with playlist browsing, shuffle, and playback controls: `lb-tui`

## Quick Start (Nix)

```bash
git clone https://github.com/mobsenpai/listenbrainz_player
cd listenbrainz_player
nix develop
lb play "Kendrick Lamar HUMBLE"
```

## Without Nix
Requirements: mpv and yt-dlp must be installed on your system.

```bash
pip install .
lb play "Artist Song"
```

## Environment Variables
Create a .env file with the following:
```text
LISTENBRAINZ_TOKEN=your_api_token_here
LB_USERNAME=your_listenbrainz_username
```
