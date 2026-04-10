#!/usr/bin/env zsh

setopt PROMPT_SUBST
autoload -Uz add-zsh-hook

: "${DEBUG:=0}"
: "${DEFAULT_USER:=$USER}"
: "${PRIMARY_FG:=black}"

typeset -g CURRENT_BG='NONE'
typeset -g PR=""
typeset -g PRIGHT=""

SEGMENT_SEPARATOR=''
RIGHT_SEPARATOR=''
LEFT_SUBSEG=''
RIGHT_SUBSEG=''

debug() {
    (( DEBUG )) && print -ru2 -- "$*"
}

text_effect() {
    case "$1" in
        reset)      print -r -- '0' ;;
        bold)       print -r -- '1' ;;
        underline)  print -r -- '4' ;;
        *)          return 1 ;;
    esac
}

fg_color() {
    case "$1" in
        default)    print -r -- '39' ;;
        black)      print -r -- '38;2;40;44;52' ;;
        red)        print -r -- '38;2;224;108;117' ;;
        green)      print -r -- '38;2;152;195;121' ;;
        yellow)     print -r -- '38;2;229;192;123' ;;
        blue)       print -r -- '38;2;97;175;239' ;;
        magenta)    print -r -- '38;2;198;120;221' ;;
        cyan)       print -r -- '38;2;86;182;194' ;;
        white)      print -r -- '38;2;171;178;191' ;;
        orange)     print -r -- '38;2;209;154;102' ;;
        *)          return 1 ;;
    esac
}

bg_color() {
    case "$1" in
        default)    print -r -- '49' ;;
        black)      print -r -- '48;2;40;44;52' ;;
        red)        print -r -- '48;2;224;108;117' ;;
        green)      print -r -- '48;2;152;195;121' ;;
        yellow)     print -r -- '48;2;229;192;123' ;;
        blue)       print -r -- '48;2;97;175;239' ;;
        magenta)    print -r -- '48;2;198;120;221' ;;
        cyan)       print -r -- '48;2;86;182;194' ;;
        white)      print -r -- '48;2;171;178;191' ;;
        orange)     print -r -- '48;2;209;154;102' ;;
        *)          return 1 ;;
    esac
}

ansi() {
    local seq="${(j:;:)@}"
    printf '%%{\033[%sm%%}' "$seq"
}

ansi_single() {
    printf '%%{\033[%sm%%}' "$1"
}

prompt_segment() {
    local bg="${1:-}"
    local fg="${2:-}"
    local text="${3:-}"
    local -a codes
    local -a transition

    debug "prompt_segment bg=$bg fg=$fg text=$text"

    codes=("$(text_effect reset)")

    [[ -n "$bg" ]] && codes+=("$(bg_color "$bg")")
    [[ -n "$fg" ]] && codes+=("$(fg_color "$fg")")

    if [[ "$CURRENT_BG" != 'NONE' && -n "$bg" && "$bg" != "$CURRENT_BG" ]]; then
        transition=("$(fg_color "$CURRENT_BG")" "$(bg_color "$bg")")
        PR+=" $(ansi "${transition[@]}")${SEGMENT_SEPARATOR}"
    fi

    PR+="$(ansi "${codes[@]}") "
    [[ -n "$text" ]] && PR+="$text"

    [[ -n "$bg" ]] && CURRENT_BG="$bg"
}

prompt_end() {
    local -a codes
    local -a reset_codes

    if [[ "$CURRENT_BG" != 'NONE' ]]; then
        codes=("$(text_effect reset)" "$(fg_color "$CURRENT_BG")")
        PR+=" $(ansi "${codes[@]}")${SEGMENT_SEPARATOR}"
    fi

    reset_codes=("$(text_effect reset)")
    PR+=" $(ansi "${reset_codes[@]}")"
    CURRENT_BG='NONE'
}

prompt_virtualenv() {
    [[ -n "$VIRTUAL_ENV" ]] || return
    prompt_segment cyan "$PRIMARY_FG" "${VIRTUAL_ENV:t}"
}

prompt_context() {
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        prompt_segment black default '%m'
    fi
}

prompt_histdt() {
    prompt_segment black default '%! [%D{%H:%M}]'
}

git_status_dirty() {
    [[ -n "$(git status --porcelain 2>/dev/null)" ]] && print -nr -- " ●"
}

prompt_git() {
    local git_exists ref dirty

    git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null  || return


    dirty="$(git_status_dirty)"

    ref="$(git symbolic-ref --quiet --short HEAD 2>/dev/null)"
    if [[ -z "$ref" ]]; then
        ref="➦ $(git rev-parse --short HEAD 2>/dev/null)"
    fi

    if [[ -n "$dirty" ]]; then
        prompt_segment red black
    else
        prompt_segment green black
    fi

    PR+=" ${ref}${dirty}"
}

prompt_dir() {
    prompt_segment blue black '%2~'
}

prompt_status() {
    local symbols=""
    local jobs_running=""

    (( RETVAL != 0 )) && symbols+="$(ansi "$(fg_color red)")✘"
    (( EUID == 0 )) && symbols+="$(ansi "$(fg_color yellow)")⚡"

    jobs_running="$(jobs -p 2>/dev/null)"
    [[ -n "$jobs_running" ]] && symbols+="$(ansi "$(fg_color cyan)")⚙"

    [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

build_prompt() {
    prompt_status
    [[ -z ${AG_NO_CONTEXT+x} ]] && prompt_context
    prompt_virtualenv
    prompt_dir
    prompt_git
    prompt_end
}

set_zsh_prompt() {
    RETVAL=$?
    PR=""
    PRIGHT=""
    CURRENT_BG='NONE'

    PR="$(ansi "$(text_effect reset)")"
    build_prompt

    PROMPT="${PR} "
    RPROMPT="${PRIGHT}"
}

add-zsh-hook precmd set_zsh_prompt
set_zsh_prompt
