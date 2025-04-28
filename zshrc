# Load support for tab completions
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select

# Use emacs key bindings
bindkey -e

# [Ctrl-RightArrow] - move forward one word
bindkey "^[[1;5C" forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey "^[[1;5D" backward-word
# [Delete] - delete forward
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

WORDCHARS=''
PROMPT=' %(?.%F{10}❯.%F{9}❯)%f %F{11}%~%f '

# History
HISTFILE="$HOME/.zsh_history" # History file
HISTSIZE=20000                # History size in memory
SAVEHIST=10000                # The number of histsize

# Options
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY          # Share history between all sessions
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_SPACE      # Do not record an entry starting with a space
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry
setopt HIST_VERIFY            # Do not execute immediately upon history expansion
setopt APPEND_HISTORY         # append to history file
setopt HIST_NO_STORE          # Don't store history commands

# Aliases
alias -g vi='vim'
alias md='mkdir -p'
alias rd='rmdir'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# List directory contents
alias -g ls='ls --color=auto'
alias -g l='ls -lhva'
alias -g ll='ls -lhv'
alias -g la='ls -lhvA'

(( $+commands[kubectl] )) && alias k='kubectl'
(( $+commands[kubectx] )) && alias kx='kubectx'
(( $+commands[kubens] )) && alias kns='kubens'

# ssh-agent
[[ "$OSTYPE" =~ "linux" ]] && (( $+commands[ssh-agent] )) && {
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
}

# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="$LANGUAGE"
export LC_ALL="$LANGUAGE"
export LC_CTYPE="$LANGUAGE"

# Editor
#export EDITOR="$commands[vim]"
#export VISUAL="$EDITOR"
#export GIT_EDITOR="$EDITOR"

# KUBECONFIG
(( $+commands[kubectl] )) && [[ -d ~/.kube ]] && {
  for config in ~/.kube/config*; do
    KUBECONFIG="$KUBECONFIG:$config"
  done
  export KUBECONFIG
}

# Automatically load completion functions
(( $+commands[kubectl] )) && source <(kubectl completion zsh)
(( $+commands[helm] )) && source <(helm completion zsh)

autoload -U +X bashcompinit && bashcompinit

(( $+commands[terraform] )) && {
  if [[ "$OSTYPE" =~ "linux" ]]; then
    complete -o nospace -C /usr/bin/terraform terraform
  elif [[ "$OSTYPE" =~ "darwin" ]]; then
    complete -o nospace -C /opt/homebrew/bin/terraform terraform
  fi
}
