#!/usr/bin/env bash
# Symlink this repo's AI configs into place, as described in links.conf.
#
#   ./install.sh            link everything (safe to re-run after `git pull`)
#   ./install.sh --dry-run  show what would change, touch nothing
#   ./install.sh --status   report the state of every link
#
# Anything already at a target that isn't our symlink is moved to
# ~/.ai-config-backups/<timestamp>/ (mirroring its path under $HOME) first.
# Symlinks into this repo whose source was deleted (e.g. a removed skill)
# are cleaned up.
#
# Works with macOS's stock bash 3.2.

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
CONF="$REPO/links.conf"
BACKUP_DIR="$HOME/.ai-config-backups/$(date +%Y%m%d-%H%M%S)"

MODE=install
case "${1:-}" in
  "")            ;;
  -n|--dry-run)  MODE=dry ;;
  -s|--status)   MODE=status ;;
  -h|--help)     sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
  *)             echo "unknown option: $1 (try --help)" >&2; exit 2 ;;
esac

if [ -t 1 ]; then
  C_OK=$'\033[32m' C_CHG=$'\033[33m' C_BAD=$'\033[31m' C_DIM=$'\033[2m' C_RST=$'\033[0m'
else
  C_OK='' C_CHG='' C_BAD='' C_DIM='' C_RST=''
fi

n_ok=0 n_changed=0 n_problem=0

say() { printf '%s%-8s%s %s\n' "$1" "$2" "$C_RST" "$3"; }
pretty() { printf '%s' "${1/#$HOME/~}"; }

run() {  # run a command unless this is a dry run
  if [ "$MODE" = install ]; then "$@"; fi
}

backup() {  # move an existing target out of the way
  local target="$1" rel dest
  rel="${target#$HOME/}"
  [ "$rel" = "$target" ] && rel="${target#/}"   # outside $HOME: use full path
  dest="$BACKUP_DIR/$rel"
  run mkdir -p "$(dirname "$dest")"
  run mv "$target" "$dest"
  say "$C_CHG" "backup" "$(pretty "$target") -> $(pretty "$dest")"
}

link() {  # link <absolute source> <absolute target>
  local src="$1" dst="$2"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    n_ok=$((n_ok + 1))
    [ "$MODE" = status ] && say "$C_OK" "ok" "$(pretty "$dst")"
    return 0
  fi

  if [ "$MODE" = status ]; then
    n_problem=$((n_problem + 1))
    if [ -L "$dst" ]; then
      say "$C_BAD" "other" "$(pretty "$dst") -> $(readlink "$dst")"
    elif [ -e "$dst" ]; then
      say "$C_BAD" "file" "$(pretty "$dst") (real file, not linked)"
    else
      say "$C_BAD" "missing" "$(pretty "$dst")"
    fi
    return 0
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    backup "$dst"
  fi
  run mkdir -p "$(dirname "$dst")"
  run ln -s "$src" "$dst"
  n_changed=$((n_changed + 1))
  say "$C_CHG" "link" "$(pretty "$dst") -> ${src#$REPO/}"
}

prune() {  # remove dangling symlinks in <dir> that point into this repo
  local dir="$1" entry dest
  [ -d "$dir" ] || return 0
  for entry in "$dir"/* "$dir"/.[!.]*; do
    [ -L "$entry" ] || continue
    dest="$(readlink "$entry")"
    case "$dest" in "$REPO"/*) ;; *) continue ;; esac
    [ -e "$entry" ] && continue
    if [ "$MODE" = status ]; then
      n_problem=$((n_problem + 1))
      say "$C_BAD" "stale" "$(pretty "$entry") -> ${dest#$REPO/}"
    else
      run rm "$entry"
      n_changed=$((n_changed + 1))
      say "$C_CHG" "remove" "$(pretty "$entry") (source gone)"
    fi
  done
}

[ "$MODE" = dry ] && echo "${C_DIM}dry run: nothing will be changed${C_RST}"

while read -r src dst _ || [ -n "${src:-}" ]; do
  case "${src:-}" in ''|'#'*) continue ;; esac
  if [ -z "${dst:-}" ]; then
    echo "links.conf: missing target for '$src'" >&2; exit 1
  fi
  dst="${dst/#\~/$HOME}"

  if [ "${src%/\*}" != "$src" ]; then          # dir/*  -> link each child
    srcdir="$REPO/${src%/\*}"
    [ -d "$srcdir" ] || { echo "links.conf: no such directory: ${src%/\*}" >&2; exit 1; }
    for child in "$srcdir"/*; do
      [ -e "$child" ] || continue
      link "$child" "$dst/$(basename "$child")"
    done
    prune "$dst"
  else
    [ -e "$REPO/$src" ] || { echo "links.conf: no such file: $src" >&2; exit 1; }
    link "$REPO/$src" "$dst"
  fi
done < "$CONF"

echo
case "$MODE" in
  status)  echo "$n_ok linked, $n_problem need attention"
           [ "$n_problem" -gt 0 ] && echo "run ./install.sh to fix" ;;
  dry)     echo "$n_ok already linked, $n_changed would change" ;;
  install) echo "$n_ok already linked, $n_changed changed"
           [ -d "$BACKUP_DIR" ] && echo "backups: $(pretty "$BACKUP_DIR")" ;;
esac
exit 0
