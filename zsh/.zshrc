# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=100000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/q1/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi


git() {
    print -ru2 -- "GIT CALLED: $PWD :: git $*"
    command git "$@"
# Re-render the ZLE buffer after every terminal resize
TRAPWINCH() {
  zle && zle .reset-prompt && zle -R
}

# Load fzf key bindings and completion
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_OPTS='
  --color=fg:#abb2bf,bg:#282c34,hl:#61afef
  --color=fg+:#f8f8f2,bg+:#3b4048,hl+:#61afef
  --color=info:#e5c07b,prompt:#98c379,pointer:#be5046
  --color=marker:#e5c07b,spinner:#61afef,header:#56b6c2
  --height 40% --layout=reverse --border=sharp
  --prompt=" " --pointer=" " --marker=" "
  --preview-window=right:60%:sharp
'

export FZF_ALT_C_OPTS="
  --preview 'tree -C {} | head -200'
  --walker-skip .git,node_modules,target,.cache,.bun,.bundle,.cargo
  --bind 'alt-space:toggle-preview'
  --header 'Use Alt +Space to toggle preview, +j/k preview page down/up, +s to sort'
  --bind 'alt-j:preview-page-down,alt-k:preview-page-up'
  --bind 'alt-s:toggle-sort'
"


# Enable Zsh completion
autoload -Uz compinit
compinit

#source ~/configs/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source ~/configs/zsh/zsh_prompt_quesnok.sh
#source ~/.zsh/zsh-ssh/zsh-ssh.zsh

# Aliases
alias ..="cd .."
alias home="cd ~"
alias zoomfix="xcompmgr -c -l0 -t0 -r0 -o.00"

alias :q="exit"
alias wr-vpn="sudo wg-quick up ~/AUTH/webrunners.conf"
alias wr-fritzbox="sudo ipsec up vpn-xauth-psk"
alias no-vpn="sudo wg-quick down"
alias no-wr-fritz="sudo ipsec down vpn-xauth-psk"

# git
alias ghist="git log --graph --oneline --decorate --all"
alias ga="git commit --amend"
# remove fragments after resolving merge conflicts
alias gorig="find . -type f \( -name '*.orig' -o -name '*_BACKUP_*' -o -name '*_BASE_*' -o -name '*_LOCAL_*' -o -name '*_REMOTE_*' \) -delete"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/q1/.bun/_bun" ] && source "/home/q1/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
