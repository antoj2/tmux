#!/usr/bin/env bash
#
# Rosé Pine - tmux theme (Cleaned for Luna variant & your config)
#

export TMUX_ROSEPINE_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

get_tmux_option() {
    local option value default
    option="$1"
    default="$2"
    value="$(tmux show-option -gqv "$option")"

    if [ -n "$value" ]; then
        echo "$value"
    else
        echo "$default"
    fi
}

set() {
    local option=$1
    local value=$2
    tmux_commands+=(set-option -gq "$option" "$value" ";")
}

setw() {
    local option=$1
    local value=$2
    tmux_commands+=(set-window-option -gq "$option" "$value" ";")
}

main() {
    local theme
    theme="$(get_tmux_option "@rose_pine_variant" "luna")"

    if [[ $theme == main ]];
        thm_base="#191724";
        thm_surface="#1f1d2e";
        thm_overlay="#26233a";
        thm_muted="#6e6a86";
        thm_subtle="#908caa";
        thm_text="#e0def4";
        thm_love="#eb6f92";
        thm_gold="#f6c177";
        thm_rose="#ebbcba";
        thm_pine="#31748f";
        thm_foam="#9ccfd8";
        thm_iris="#c4a7e7";
        thm_hl_low="#21202e";
        thm_hl_med="#403d52";
        thm_hl_high="#524f67";
    elif [[ $theme == dawn ]]; then
        thm_base="#faf4ed";
        thm_surface="#fffaf3";
        thm_overlay="#f2e9e1";
        thm_muted="#9893a5";
        thm_subtle="#797593";
        thm_text="#575279";
        thm_love="#b4637a";
        thm_gold="#ea9d34";
        thm_rose="#d7827e";
        thm_pine="#286983";
        thm_foam="#56949f";
        thm_iris="#907aa9";
        thm_hl_low="#f4ede8";
        thm_hl_med="#dfdad9";
        thm_hl_high="#cecacd";
    elif [[ $theme == moon ]]; then
        thm_base="#232136";
        thm_surface="#2a273f";
        thm_overlay="#393552";
        thm_muted="#6e6a86";
        thm_subtle="#908caa";
        thm_text="#e0def4";
        thm_love="#eb6f92";
        thm_gold="#f6c177";
        thm_rose="#ea9a97";
        thm_pine="#3e8fb0";
        thm_foam="#9ccfd8";
        thm_iris="#c4a7e7";
        thm_hl_low="#2a283e";
        thm_hl_med="#44415a";
        thm_hl_high="#56526e";
    elif [[ $theme == mellow ]]; then
        thm_base="#1b1b1d";
        thm_surface="#2a273f";
        thm_overlay="#393552";
        thm_muted="#6e6a86";
        thm_subtle="#908caa";
        thm_text="#e0def4";
        thm_love="#eb6f92";
        thm_gold="#f6c177";
        thm_rose="#ea9a97";
        thm_pine="#3e8fb0";
        thm_foam="#eb6f92";
        thm_iris="#ea83a5";
        thm_hl_low="#2a283e";
        thm_hl_med="#44415a";
        thm_hl_high="#56526e";
    elif [[ $theme == luna ]]; then
        thm_base="#0f0f0f";
        thm_muted="#7c7c7c";
        thm_subtle="#605958";
        thm_text="#e0def4";
        thm_love="#eb6f92";
        thm_gold="#f6c177";
        thm_rose="#ea9a97";
        thm_pine="#3e8fb0";
        thm_foam="#eb6f92";
        thm_iris="#ea83a5";
        thm_hl_low="#2a283e";
        thm_hl_med="#44415a";
        thm_hl_high="#56526e";
    fi

    local tmux_commands=()

    # Status bar base setup
    set "status" "on"
    set status-style "fg=$thm_pine,bg=$thm_base"
    set status-left-length "200"
    set status-right-length "200"

    # Messages / command prompt
    set message-style "fg=$thm_muted,bg=$thm_base,fill=$thm_base"
    set message-command-style "fg=$thm_base,bg=$thm_gold,fill=$thm_gold"

    # Pane styling
    set pane-border-style "fg=$thm_hl_high"
    set pane-active-border-style "fg=$thm_gold"
    set display-panes-active-colour "${thm_text}"
    set display-panes-colour "${thm_gold}"

    # Windows styling
    setw window-status-style "fg=${thm_iris},bg=${thm_base}"
    setw window-status-activity-style "fg=${thm_base},bg=${thm_rose}"
    setw window-status-current-style "fg=${thm_gold},bg=${thm_base}"

    # Read configuration options
    local user
    user="$(get_tmux_option "@rose_pine_user" "")"
    readonly user

    local date_time
    date_time="$(get_tmux_option "@rose_pine_date_time" "")"
    readonly date_time

    local disable_active_window_menu
    disable_active_window_menu="$(get_tmux_option "@rose_pine_disable_active_window_menu" "")"

    local window_separator 
    window_separator="$(get_tmux_option "@rose_pine_window_separator" "")"
    readonly window_separator 

    local status_left_prepend_section
    status_left_prepend_section="$(get_tmux_option "@rose_pine_status_left_prepend_section" "")"
    readonly status_left_prepend_section

    # Icons & Separators
    local current_session_icon
    current_session_icon="$(get_tmux_option "@rose_pine_session_icon" "")"
    readonly current_session_icon

    local username_icon
    username_icon="$(get_tmux_option "@rose_pine_username_icon" "")"
    readonly username_icon

    local date_time_icon
    date_time_icon="$(get_tmux_option "@rose_pine_date_time_icon" "󰃰")"
    readonly date_time_icon

    local right_separator
    right_separator="$(get_tmux_option "@rose_pine_right_separator" "  ")"
    readonly right_separator

    local left_separator
    left_separator="$(get_tmux_option "@rose_pine_left_separator" "  ")"
    readonly left_separator

    local field_separator
    field_separator="$(get_tmux_option "@rose_pine_field_separator" "  ")"
    field_separator="#[fg=$thm_text]$field_separator"

    local spacer=" "

    # Module definitions
    local show_session
    readonly show_session="#[fg=#{?client_prefix,$thm_love,$thm_text}]$current_session_icon #[fg=$thm_text]#S"

    local show_user
    readonly show_user="#[fg=$thm_iris]#(whoami)#[fg=$thm_subtle]$right_separator#[fg=$thm_subtle]$username_icon"

    local show_date_time
    readonly show_date_time="#[fg=$thm_foam]$date_time#[fg=$thm_subtle]$right_separator#[fg=$thm_subtle]$date_time_icon #[fg=$thm_text]"

    # Custom window status format
    local custom_window_sep="#[fg=$thm_iris]#I#[fg=$thm_iris,]$window_separator#[fg=$thm_iris]#W"
    local custom_window_sep_current="#I#[fg=$thm_gold,bg=""]$window_separator#[fg=$thm_gold,bg=""]#W"

    if [[ "$window_separator" != "" ]] ; then
        setw window-status-format "$custom_window_sep"
        setw window-status-current-format "$custom_window_sep_current"
    fi

    # Build Right Column
    local right_column=""
    if [[ "$user" == "on" ]]; then
        right_column="$right_column$show_user"
    fi

    if [[ "$date_time" != "" ]]; then
        right_column="$right_column$show_date_time"
    fi

    # Build Left Column
    local left_column=""
    if [[ "$disable_active_window_menu" == "on" ]]; then
        left_column="$show_session$spacer"
    else
        local show_window
        show_window="#[fg=$thm_subtle] #[fg=$thm_rose]#W#[fg=$thm_text]"
        left_column="$show_session$field_separator$show_window$field_separator"
    fi

    # Zoomed flag indicator
    left_column="#{?window_zoomed_flag,🔍,}$left_column"

    # Prepend section (e.g., for tmux-mode-indicator)
    if [[ "$status_left_prepend_section" != "" ]]; then
        left_column="$status_left_prepend_section$left_column"
    fi

    # Set final status-left and status-right positions
    set status-left "$left_column"
    set status-right "$right_column"

    # Tmux integrated modes styling
    setw clock-mode-colour "${thm_love}"
    setw mode-style "bg=${thm_hl_med}"

    # Execute all generated tmux commands
    tmux "${tmux_commands[@]}"
}

main "$@"
