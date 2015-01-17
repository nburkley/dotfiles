" Use Vim settings, rather then Vi settings.
set nocompatible

" set character encoding to utf-8
scriptencoding utf-8
set encoding=utf-8

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Use plugins install by vundle
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" remap jj to esc
ino jj <esc>
cno jj <c-c>

" use filetype detection
filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" don't use vim backup files
set nobackup
set nowritebackup

set ruler               " turn on ruler
set number              " add line numbers
set colorcolumn=80      " add line marker at 80 characters
setlocal spell          " turn on spellcheck
colorscheme railscasts  " use railscasts colorscheme

" NERDtree
autocmd vimenter * NERDTree       " open on startup
map <C-n> :NERDTreeToggle<CR>     " toggle with Ctl+n
" close vim of only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif