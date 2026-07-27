#!/usr/bin/env bash
# fzf-based tmux session switcher. Lists running sessions (tagged with
# Claude Code status, if a pane is running claude) plus every ~/workspace
# dir zoxide knows about that doesn't have a session yet — zoxide's
# frecency order lines up the top pick, but nothing is hidden since fzf's
# own fuzzy filter handles scale instead of a hard cap. ctrl-x kills a
# session in place.
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

# Path map for dir candidates, since the name (workspace-relative path
# with "." and ":" scrubbed, e.g. "archive/football") isn't always the
# literal $workspace/<name> path once scrubbed.
map_file="${TMPDIR:-/tmp}/tmux-sessionizer-paths"

list_entries() {
    local sessions=$'\n' session path name

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

    while IFS= read -r path; do
        case "$path" in "$workspace"/*) ;; *) continue ;; esac
        name=$(echo "${path#"$workspace"/}" | tr '.:' '__')
        case "$sessions" in *$'\n'"$name"$'\n'*) continue ;; esac
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

    # tmuxinator project config wins if present: project-local
    # .tmuxinator.yml first, then a same-named config in the shared
    # tmuxinator dir. Neither found falls back to a plain session.
    local_config=""
    home_config=""
    for ext in yml yaml; do
        [ -z "$local_config" ] && [ -f "$path/.tmuxinator.$ext" ] && local_config="$path/.tmuxinator.$ext"
        [ -z "$home_config" ] && [ -f "$HOME/.config/tmuxinator/$(basename "$path").$ext" ] \
            && home_config="$HOME/.config/tmuxinator/$(basename "$path").$ext"
    done

    if [ -n "$local_config" ] && command -v tmuxinator >/dev/null 2>&1; then
        tmuxinator start -p "$local_config" -n "$name" --no-attach
    elif [ -n "$home_config" ] && command -v tmuxinator >/dev/null 2>&1; then
        tmuxinator start "$(basename "$path")" -n "$name" --no-attach
    else
        tmux new-session -d -s "$name" -c "$path"
        tmux send-keys -t "$name" "nvim ." Enter
    fi
fi

if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "=$name"
else
    tmux attach-session -t "=$name"
fi
