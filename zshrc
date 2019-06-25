#--------------------------------------------------------------
# General Settings
#--------------------------------------------------------------

# set language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# use oh-my-zsh theme
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# use NeoVim as an editor
export EDITOR='nvim'

#--------------------------------------------------------------
# History Settings
#--------------------------------------------------------------

# Append every command to the history file
# But don't store duplicates or spaces
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# store history in ~/.zhistory
HISTFILE=~/.zhistory

# read/write 10_000 lines of history
HISTSIZE=10000
SAVEHIST=10000

# search history with arrows
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

#--------------------------------------------------------------
# Navigation and input
#--------------------------------------------------------------

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Try to correct command line spelling
setopt correct correctall

# Enable extended globbing
setopt extendedglob

# vi mode
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# don't auto rename in tmux
export DISABLE_AUTO_TITLE=true

#--------------------------------------------------------------
# Source other files
#--------------------------------------------------------------

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Use fuzzy finder shell (https://github.com/junegunn/fzf) in zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.zshenv

#--------------------------------------------------------------
# FZF fuzzy finder
#--------------------------------------------------------------

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

#--------------------------------------------------------------
# Kubernetes
#--------------------------------------------------------------

# enable kubectl autocompletion
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# enable stern auto-complete
source <(stern --completion=zsh)

if [ $commands[stern] ]; then
  source <(stern --completion=zsh)
fi

#--------------------------------------------------------------
# ASDF version manager
#--------------------------------------------------------------

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
