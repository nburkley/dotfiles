# set language
export LANG=en.UTF-8

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# use oh-my-zsh theme
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# use NeoVim as an editor
export EDITOR='nvim'

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# search history with arrows
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

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

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Use fuzy finder shell (https://github.com/junegunn/fzf) in zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use nvm to manage node versions
export NVM_DIR="/Users/nburkley/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Use global .agignore file
alias ag='ag --path-to-agignore ~/.agignore'

# Enable syntax highlighting with `less` using source-highlight
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=" -R "
alias less='less -m -N -g -i -J --underline-special --SILENT'
alias more='less'
