function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix ' >'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix ' #'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -n -s '🐢 ' (set_color $bold_flag $color_cwd) (prompt_pwd) $normal (set_color $bold_flag $fish_color_param) (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # Abbreviations
    abbr w 'cd ~/workspace'
    abbr .d 'cd ~/workspace/dotfiles'

    abbr gc 'git commit -m'
    abbr gp 'git pull'
    abbr gst 'git status --short --branch'
    abbr gs 'git add .'
    abbr gus 'git reset HEAD'
    abbr guc 'git reset --soft HEAD^'
    abbr gg 'git push'
    abbr gb 'git branch'
    abbr gco 'git checkout'

    # Good looking lists
    abbr ll 'exa -la --git --icons'

    # Better / colored cat command
    abbr cat 'bat'

    # Grab your ip address
    abbr ip "echo Your ip is; dig +short myip.opendns.com @resolver1.opendns.com;"

    # Raycast aliases
    abbr raylog "log stream --predicate \"subsystem == 'com.raycast.macos'\" --level debug --style compact"

    # Use coreutils instead of mac defaults
    abbr date gdate

    # Redirect vim to nvim
    abbr vim nvim
end

set fish_greeting ""
set homebrew /usr/local/bin /usr/local/sbin /opt/homebrew/bin
set -x NVM_DIR ~/.nvm
set -gx PATH $homebrew $PATH
set --universal nvm_default_version 18
