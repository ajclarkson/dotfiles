#!/bin/bash
# Claude Code status line — based on fish_prompt from ~/.config/fish/ajclarkson/prompt.fish
# Colours: Rose Pine (https://rosepinetheme.com/palette)

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // ""')
effort=$(echo "$input" | jq -r '.effort.level // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_h_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_h_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Rose Pine palette (truecolor)
c_love='\033[38;2;235;111;146m'   # red    — high context warning
c_gold='\033[38;2;246;193;119m'   # yellow — model
c_rose='\033[38;2;235;188;186m'   # pink   — spend today
c_pine='\033[38;2;49;116;143m'    # blue   — cwd
c_foam='\033[38;2;156;207;216m'   # cyan   — context %
c_iris='\033[38;2;196;167;231m'   # purple — git branch
c_muted='\033[38;2;110;106;134m'  # muted  — separators / daily avg
c_subtle='\033[38;2;144;140;170m' # subtle — effort / labels
c_reset='\033[0m'

sep=" ${c_muted}|${c_reset} "

# Shorten the path like prompt_pwd: replace $HOME with ~, show last 2 components
home="$HOME"
short_cwd="${cwd/#$home/~}"
short_cwd=$(echo "$short_cwd" | awk -F'/' '{
    if (NF <= 3) { print $0 }
    else { print $1 "/" $2 "/.../" $(NF-1) "/" $NF }
}')

# Git branch (skip optional locks to avoid hanging)
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
             || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        git_info=" (${c_iris}${branch}${c_reset})"
    fi
fi

# Model + effort
model_info=""
if [ -n "$model" ]; then
    model_info="${c_gold}${model}${c_reset}"
    if [ -n "$effort" ]; then
        model_info="${model_info} ${c_subtle}(${effort})${c_reset}"
    fi
fi

# Context used %, coloured Love (red) if over 60%
ctx_info=""
if [ -n "$used_pct" ]; then
    ctx_colour="$c_foam"
    if awk "BEGIN{exit !($used_pct > 60)}"; then
        ctx_colour="$c_love"
    fi
    ctx_info="${c_subtle}Context:${c_reset} ${ctx_colour}${used_pct}%${c_reset}"
fi

# Rate-limit tier colouring: normal < 70%, warn 70-89%, high >= 90%
rate_limit_colour() {
    local pct_int
    pct_int=$(printf '%.0f' "$1")
    if [ "$pct_int" -ge 90 ]; then echo "$c_love"
    elif [ "$pct_int" -ge 70 ]; then echo "$c_gold"
    else echo "$c_foam"; fi
}

spend_info=""
if command -v /Users/adam.clarkson/.local/bin/claude-usage > /dev/null 2>&1; then
    # Claude spend (today | 30-day avg/day)
    today_cost=$(/Users/adam.clarkson/.local/bin/claude-usage report --format '{today_cost}' 2>/dev/null)
    avg_cost=$(/Users/adam.clarkson/.local/bin/claude-usage report --format '{avg_daily_cost_30d}' 2>/dev/null)
    if [ -n "$today_cost" ]; then
        today_colour="$c_rose"
        today_num=$(echo "$today_cost" | tr -dc '0-9.')
        if [ -n "$today_num" ] && awk "BEGIN{exit !($today_num > 30)}"; then
            today_colour="$c_love"
        fi
        spend_info="${c_subtle}Today:${c_reset} ${today_colour}${today_cost}${c_reset}"
    fi
    if [ -n "$avg_cost" ]; then
        spend_info="${spend_info}${sep}${c_subtle}Daily Average:${c_reset} ${c_muted}${avg_cost}${c_reset}"
    fi
elif [ -n "$five_h_pct" ] || [ -n "$week_pct" ]; then
    # Plan rate limits (5h | 7d)
    if [ -n "$five_h_pct" ]; then
        five_h_colour=$(rate_limit_colour "$five_h_pct")
        five_h_int=$(printf '%.0f' "$five_h_pct")

        reset_str=""
        if [ -n "$five_h_reset" ]; then
            now=$(date +%s)
            secs_left=$((five_h_reset - now))
            if [ "$secs_left" -gt 0 ]; then
                hrs_left=$((secs_left / 3600))
                mins_left=$(((secs_left % 3600) / 60))
                if [ "$hrs_left" -gt 0 ]; then
                    reset_str=" ${c_muted}↺ ${hrs_left}h${mins_left}m${c_reset}"
                else
                    reset_str=" ${c_muted}↺ ${mins_left}m${c_reset}"
                fi
            fi
        fi

        spend_info="${c_subtle}5h:${c_reset} ${five_h_colour}${five_h_int}%${c_reset}${reset_str}"
    fi
    if [ -n "$week_pct" ]; then
        week_colour=$(rate_limit_colour "$week_pct")
        week_int=$(printf '%.0f' "$week_pct")
        [ -n "$spend_info" ] && spend_info="${spend_info}${sep}"
        spend_info="${spend_info}${c_subtle}7d:${c_reset} ${week_colour}${week_int}%${c_reset}"
    fi
fi

parts=("🐢 ${c_pine}${short_cwd}${c_reset}${git_info}")
[ -n "$model_info" ] && parts+=("$model_info")
[ -n "$ctx_info" ] && parts+=("$ctx_info")
[ -n "$spend_info" ] && parts+=("$spend_info")

out=""
for p in "${parts[@]}"; do
    if [ -z "$out" ]; then
        out="$p"
    else
        out="${out}${sep}${p}"
    fi
done

printf "%b" "$out"
