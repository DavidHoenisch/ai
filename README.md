# ai

Personal AI agent config — skills, global instructions, and settings for
Claude Code, Codex, OpenCode, and Pi — symlinked into place on every machine.

## Setup on a new machine

```sh
git clone <this repo> ~/code/ai
cd ~/code/ai
./install.sh --dry-run   # preview
./install.sh
```

After that, `git pull` is usually enough: everything is a symlink, so edits
show up immediately. Re-run `./install.sh` when you **add or remove** a skill
or a `links.conf` entry. It's safe to re-run any time.

`./install.sh --status` shows anything missing, overwritten, or stale.

## Make targets

| Command | What it does |
|---|---|
| `make setup` | New machine: pull latest, then link everything |
| `make pull` | Pull remote changes (local edits are kept) and re-link |
| `make push m="msg"` | Commit all local changes and push (message optional) |
| `make sync m="msg"` | Commit local, pull remote, push, re-link |
| `make status` | Git changes plus the state of every link |
| `make diff` | Show uncommitted config changes |
| `make install` / `make dry-run` | Run or preview `install.sh` |

## Layout

| Path | Linked to |
|---|---|
| `agents/AGENTS.md` | `~/.agents/`, `~/.codex/`, `~/.config/opencode/`, `~/.pi/agent/` (as AGENTS.md); `~/.claude/CLAUDE.md` |
| `claude/settings.json` | `~/.claude/settings.json` |
| `opencode/opencode.json` | `~/.config/opencode/opencode.json` |
| `pi/mcp.json` | `~/.pi/agent/mcp.json` |
| `skills/<name>/` | `~/.claude/skills/<name>`, `~/.agents/skills/<name>` |

`links.conf` is the source of truth — add a line there to link something new.
Skills are linked one folder at a time, so each agent can still keep
machine-local skills next to the shared ones.

## How install.sh treats existing files

- Already our symlink → left alone.
- Anything else at the target → moved to `~/.ai-config-backups/<timestamp>/`, then linked.
- Symlinks into this repo whose source was deleted → removed.

## Deliberately not tracked

- `~/.claude/settings.local.json` — per-machine overrides.
- `~/.claude/hooks/`, OpenCode `tui.jsonc`/`cli.json`/plugins, Pi extensions —
  written by herdr's installer; reinstall herdr instead.
- `~/.pi/agent/settings.json` — Pi writes `deviceId`/`lastChangelogVersion` into it.
- `~/.codex/config.toml` — Codex writes per-project trust and app state into it.

## Gotcha

Some tools save settings by writing a new file and renaming it over the old
one, which replaces the symlink with a regular file. If `--status` reports
`file` for a settings path, copy any changes you want into the repo and
re-run `./install.sh`.
