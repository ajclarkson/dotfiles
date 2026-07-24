#!/usr/bin/env bash
# fzf-based tmux session switcher. Lists running sessions (tagged with
# Claude Code status, if a pane is running claude) plus ~/workspace dirs
# zoxide knows about that don't have a session yet — frecency-ranked
# instead of walking the whole tree, so it stays fast and uncluttered
# even with 100+ clones on disk. ctrl-x kills a session in place.
set -euo pipefail

workspace="$HOME/workspace"

# One dot per line, colour-coded, so liveness and Claude status share a
# single unobtrusive glyph rather than a badge per line:
#   green  ● session running, Claude waiting for input ("✳" in pane title)
#   yellow ● session running, Claude still working (spinner frame in title)
#   white  ● session running, no Claude pane
#   dim    ○ not running yet (known to zoxide, no session)
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

# Path map for dir candidates, since a disambiguated name (e.g.
# "archive_football" for two dirs both called "football") doesn't map
# 1:1 onto $workspace/<name>.
map_file="${TMPDIR:-/tmp}/tmux-sessionizer-paths"

# Most zoxide entries a --list run will surface for dirs with no session yet.
# Ranked by frecency, so it's always the most-recently/often-used ones;
# anything older is a manual `cd` + `tmux new-session` away.
max_new=10

list_entries() {
    local sessions=$'\n' dirs_seen=$'\n' session path name parent new_count=0

    : > "$map_file"

    # Most-recently-attached first, current session last — so the top
    # entry (fzf's default selection) is always the *previous* session,
    # and enter with no typing is a quick toggle back to it.
    while IFS=$'\t' read -r _ _ session; do
        [ -z "$session" ] && continue
        sessions="${sessions}${session}"$'\n'
        printf '%s %s\n' "$(session_marker "$session")" "$session"
    done < <(tmux list-sessions -F "#{session_last_attached}	#{session_attached}	#{session_name}" 2>/dev/null \
        | sort -t $'\t' -k2,2n -k1,1nr)

    while [ "$new_count" -lt "$max_new" ] && IFS= read -r path; do
        case "$path" in "$workspace"/*) ;; *) continue ;; esac
        name=$(basename "$path" | tr '.:' '__')
        case "$sessions" in *$'\n'"$name"$'\n'*) continue ;; esac
        case "$dirs_seen" in
            *$'\n'"$name"$'\n'*)
                parent=$(basename "$(dirname "$path")")
                name="${parent}_${name}"
                ;;
        esac
        case "$dirs_seen" in *$'\n'"$name"$'\n'*) continue ;; esac
        dirs_seen="${dirs_seen}${name}"$'\n'
        new_count=$((new_count + 1))
        printf '%s\t%s\n' "$name" "$path" >> "$map_file"
        printf '%s %s\n' "$new_marker" "$name"
    done < <(zoxide query -l 2>/dev/null)
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

if ! tmux has-session -t "=$name" 2>/dev/null; then
    path=$(awk -F'\t' -v n="$name" '$1 == n { p = $2 } END { print p }' "$map_file")
    [ -z "$path" ] && path="$workspace/$name"
    tmux new-session -d -s "$name" -c "$path"
fi

if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "=$name"
else
    tmux attach-session -t "=$name"
fi
