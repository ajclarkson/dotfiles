#!/usr/bin/env bash
# Per-session Claude Code status for the statusline. Only sessions with a
# claude pane show up at all, so the list tracks things that need attention
# rather than how many sessions happen to be open. Same title convention the
# sessionizer reads:
#   "✳"-prefixed title  -> waiting for input
#   any other non-empty title on a claude pane -> still working
set -euo pipefail

waiting=""
working=""

while IFS= read -r session; do
    [ -z "$session" ] && continue
    title=$(tmux list-panes -t "$session" -F "#{pane_current_command} #{pane_title}" 2>/dev/null \
        | awk '$1 == "claude" { $1 = ""; print substr($0, 2); exit }')
    case "$title" in
        "✳"*) waiting="${waiting}#[fg=green]✳ ${session}#[default] " ;;
        "")   ;; # no claude pane, skip
        *)    working="${working}#[fg=yellow]⚙ ${session}#[default] " ;;
    esac
done < <(tmux list-sessions -F "#{session_name}" 2>/dev/null)

printf '%s%s' "$waiting" "$working"
