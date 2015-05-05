" Use Vim settings, rather then Vi settings.
set nocompatible

" use space as leader key
let mapleader = " "

" set character encoding to utf-8
scriptencoding utf-8
set encoding=utf-8

" set font to Source Code Pro, size 13
set gfn=Source\ Code\ Pro\ Medium:h13

" don't use swap files
set noswapfile

" Reload files if changed outside vim
set autoread

" set some directories to be ignored
set wildignore+=tmp/**
set wildignore+=public/uploads/**
set wildignore+=public/images/**
set wildignore+=vendor/**
set wildignore+=log/**
set wildignore+=spec/support/vcr_cassettes/**

" Share the clipboard outside of macvim
set clipboard=unnamed

" Get off my lawn
noremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" create Ag command for global search
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" bind \ to grep Ag shortcut
nnoremap \ :Ag<SPACE>

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

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Better split defaults
set splitbelow
set splitright

" don't use vim backup files
set nobackup
set nowritebackup

set ruler               " turn on ruler
set number              " add line numbers
set colorcolumn=80      " add line marker at 80 characters
colorscheme railscasts  " use railscasts colorscheme

" NERDtree
" autocmd vimenter * NERDTree       " open on startup
map <leader>n :NERDTreeToggle<CR>     " toggle with leader+n
map <leader>r :NERDTreeFind<CR>
" close vim of only NERDTree is open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" vim-airline

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" TComment
" Toggle comments with leader-c
map <leader>/ <c-_><c-_>

" Buffers
" This allows buffers to be hidden if you've modified a buffer.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>


" Ctrl-P
" add Ctr-B as shortcut for buffer search
nnoremap <C-B> :CtrlPBuffer<cr>

" Ignore some files and file types when indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|public\/images\|public\/system\|data\|log\|spec\/support\/vcr_cassettes\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }

" User the silver searcher with Ctrl-P if it's available
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif