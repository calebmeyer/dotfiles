# Path to your oh-my-zsh installation.
export ZSH=/Users/cm022291/.oh-my-zsh

DISABLE_CORRECTION="true"

# User configuration

export PATH="/usr/local/bin:/Users/cm022291/.bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/cm022291/.rvm/bin:$PATH"

export GEM_HOME="/Users/cm022291/.rvm/rubies/ruby-2.1.5/lib/ruby/gems/2.1.0"
export GEM_PATH="$GEM_HOME"

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

source ~/.oh-my-zsh/aliases.zsh
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias git="hub"

source ~/.dotfiles/binaries/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle rvm

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

export PATH="$HOME/.bin:$PATH"
