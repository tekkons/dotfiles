# Load support for tab completions
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select

# Bindings
bindkey -e    # Emacs key binding

if [[ "$OSTYPE" =~ "linux" ]]; then
  # Ctrl + left/right arrow keys
  bindkey "^[[1;5C" forward-word
  bindkey "^[[1;5D" backward-word
fi

PROMPT=' %(?.%F{10}❯.%F{9}❯)%f %F{11}%~%f '

# History
HISTFILE=$HOME/.zsh_history   # History file
HISTSIZE=10000                # History size in memory
SAVEHIST=100000               # The number of histsize

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
if [[ "$OSTYPE" =~ "darwin" ]]; then
  # ls
  alias ls='ls --color=auto'
  alias ll='ls -lh'
  alias la='ls -lha'
elif [[ "$OSTYPE" =~ "linux" ]]; then
  # ls
  alias ls='ls --color=auto'
  alias ll='ls --group-directories-first --human-readable -lv'
  alias la='ls --group-directories-first --human-readable -lv --all'
fi

alias vi='vim'
alias cht='cht.sh'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

(( $+commands[kubectl] )) && alias k='kubectl'
(( $+commands[kubectx] )) && alias kx='kubectx'
(( $+commands[kubens] )) && alias kns='kubens'

# ENVS
[[ "$OSTYPE" =~ "linux" ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

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

# Autocompletion scripts
source <(kubectl completion zsh)
source <(helm completion zsh)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

