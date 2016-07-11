# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# use oh-my-zsh theme
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# set custom prompt
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}/$(basename "$(dirname "${PWD}")")/$(basename "${PWD}") %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

# use MacVim as an editor
export EDITOR='mvim'

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
