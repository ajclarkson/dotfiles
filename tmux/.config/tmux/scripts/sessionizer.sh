#!/usr/bin/env bash
# fzf-based tmux session switcher. Lists running sessions (tagged with
# Claude Code status, if a pane is running claude) plus project dirs under
# ~/workspace that don't have a session yet. ctrl-x kills the highlighted
# session without leaving the picker.
set -euo pipefail

search_dirs=("$HOME/workspace")

# One dot per line, colour-coded, so liveness and Claude status share a
# single unobtrusive glyph rather than a badge per line:
#   green  ● session running, Claude waiting for input ("✳" in pane title)
#   yellow ● session running, Claude still working (spinner frame in title)
#   white  ● session running, no Claude pane
#   dim    ○ not running yet (a ~/workspace dir)
session_marker() {
    local session="$1" title
    title=$(tmux list-panes -t "$session" -F "#{pane_current_command} #{pane_title}" 2>/dev/null \
        | awk '$1 == "claude" { $1 = ""; print substr($0, 2); exit }')
    case "$title" in
        "✳"*) echo $'\033[32m●\033[0m' ;;  # waiting
        "")   echo $'\033[37m●\033[0m' ;;  # no claude pane
        *)    echo $'\033[33m●\033[0m' ;;  # working
    esac
}

new_marker=$'\033[2m○\033[0m'

list_entries() {
    local seen=$'\n' session dir path name
    while IFS= read -r session; do
        [ -z "$session" ] && continue
        seen="${seen}${session}"$'\n'
        printf '%s %s\n' "$(session_marker "$session")" "$session"
    done < <(tmux list-sessions -F "#{session_name}" 2>/dev/null)

    for dir in "${search_dirs[@]}"; do
        [ -d "$dir" ] || continue
        while IFS= read -r path; do
            name=$(basename "$path" | tr '.:' '__')
            case "$seen" in *$'\n'"$name"$'\n'*) continue ;; esac
            printf '%s %s\n' "$new_marker" "$name"
        done < <(find "$dir" -mindepth 1 -maxdepth 1 -type d)
    done
}

if [ "${1:-}" = "--list" ]; then
    list_entries
    exit 0
fi

self="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"

entries="$(list_entries)"
[ -z "$entries" ] && exit 0

header=$(printf '%s waiting  %s working  %s no claude  %s new   enter: switch/create   ctrl-x: kill session' \
    $'\033[32m●\033[0m' $'\033[33m●\033[0m' $'\033[37m●\033[0m' "$new_marker")

chosen=$(printf '%s\n' "$entries" | fzf --prompt="session> " --no-preview --ansi \
    --header "$header" \
    --bind "ctrl-x:execute-silent(tmux kill-session -t {-1} 2>/dev/null)+reload($self --list)")
[ -z "$chosen" ] && exit 0

name=$(echo "$chosen" | awk '{print $NF}')
path="$HOME/workspace/$name"

if ! tmux has-session -t "=$name" 2>/dev/null; then
    tmux new-session -d -s "$name" -c "$path"
fi

if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "=$name"
else
    tmux attach-session -t "=$name"
fi
