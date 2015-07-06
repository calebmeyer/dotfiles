# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

DISABLE_CORRECTION="true"

# User configuration

export PATH="/usr/local/bin:$HOME/.bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin:$HOME/.jenv/bin:$PATH"

export GEM_HOME="$HOME/.rvm/rubies/ruby-2.1.5/lib/ruby/gems/2.1.0"
export GEM_PATH="$GEM_HOME"

source $ZSH/oh-my-zsh.sh
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='atom -w'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

source ~/.aliases.zsh
if [ -f ~/.docker.zsh ]; then source ~/.docker.zsh; fi

source ~/.dotfiles/binaries/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle rvm
antigen bundle compleat
antigen bundle z

antigen bundle zsh-users/zsh-syntax-highlighting
# syntax highlighting color changes:
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[pre-command]='fg=cyan,bold,underline'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=cyan,underline'

# vim text objects, so I can do ci" to change inside quotes
antigen bundle hchbaw/opp.zsh opp.zsh

# # Setup zsh-autosuggestions
# antigen bundle tarruda/zsh-autosuggestions
#
# # Enable autosuggestions automatically
# zle-line-init() {
#   zle autosuggest-start
# }
# zle -N zle-line-init
#
# # right arrow accepts entire suggestion.
# AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1
#
# bindkey '^T' autosuggest-toggle
#
# antigen bundle zsh-users/zsh-history-substring-search

antigen theme calebmeyer/cpm-zsh-theme cpm

antigen apply

export PATH="$HOME/.bin:$PATH"

# make the terminal work like vim
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^r' history-incremental-search-backward

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
