" Use Vim settings, rather then Vi settings.
set nocompatible

" set character encoding to utf-8
scriptencoding utf-8
set encoding=utf-8

" set font to Source Code Pro, size 13
set gfn=Source\ Code\ Pro\ Medium:h13

" don't use swap files
set noswapfile

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
setlocal spell          " turn on spellcheck
colorscheme railscasts  " use railscasts colorscheme

" NERDtree
" autocmd vimenter * NERDTree       " open on startup
map <C-n> :NERDTreeToggle<CR>     " toggle with Ctl+n
map <leader>r :NERDTreeFind<CR>
" close vim of only NERDTree is open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" vim-airline

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


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
