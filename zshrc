# This file will be loaded for interactive shells. For commands which are not specific to interactive shells,
# use .zshenv instead.

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZDOTDIR=$HOME

# Zsh, I know what I'm doing when I type rake, and it wasn't that I intended to type make. Same for mvim.
DISABLE_CORRECTION="true"

export GEM_HOME="$HOME/.rvm/rubies/ruby-2.1.5/lib/ruby/gems/2.1.0"
export GEM_PATH="$GEM_HOME"

export GO_PATH="$HOME/go_workspace/packages"

export PATH="/usr/local/bin:$HOME/.bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/anaconda3/bin:$HOME/.rvm/bin:$HOME/.jenv/bin:$GO_PATH:$PATH"

source $ZSH/oh-my-zsh.sh
# if which jenv > /dev/null; then eval "$(jenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

if [ -f ~/.docker.zsh ]; then source ~/.docker.zsh; fi

source ~/.dotfiles/binaries/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle rimraf/k

antigen bundle zsh-users/zsh-syntax-highlighting
# syntax highlighting color changes:
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[pre-command]='fg=cyan,bold,underline'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=cyan,underline'

antigen theme calebmeyer/cpm-zsh-theme cpm

antigen apply

# make the terminal work like vim
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^r' history-incremental-search-backward

# zle -N zle-line-init
# zle -N zle-keymap-select
# export KEYTIMEOUT=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f ~/.aliases.zsh ]; then source ~/.aliases.zsh; fi
