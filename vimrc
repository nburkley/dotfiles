"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather then Vi settings.
set nocompatible

" set character encoding to utf-8
scriptencoding utfs8
set encoding=utf-8

" don't use swap files
set noswapfile

" Reload files if changed outside vim
set autoread

" use filetype detection
filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Share the clipboard outside of macvim
set clipboard=unnamed

" Auto format any pasted text
nnoremap P P=`]
nnoremap p p=`]

" don't use vim backup files
set nobackup
set nowritebackup

" Use plugins install by vundle
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Enable spellchecking for Markdown files and git commit messages
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look and feel
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set font to Source Code Pro, patched for Powerline, size 13
set gfn=Source\ Code\ Pro\ for\ Powerline:h13

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

set ruler               " turn on ruler
set number              " add line numbers
set colorcolumn=80      " add line marker at 80 characters
colorscheme railscasts  " use railscasts colorscheme

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings and shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use space as leader key
let mapleader = " "

" remap jj to esc
ino jj <esc>
cno jj <c-c>

" remap Ctrl-s to save and exit insert
noremap  <c-s> :update<cr>
vnoremap <c-s> <c-c>:update<cr>
inoremap <c-s> <c-o>:update<cr><esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching and indexing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" set some directories to be ignored
set wildignore+=tmp/**
set wildignore+=public/uploads/**
set wildignore+=public/images/**
set wildignore+=vendor/**
set wildignore+=log/**
set wildignore+=spec/support/vcr_cassettes/**

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows, buffers & navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make arrowkey do something usefull, resize the viewports accordingly
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

" Better split defaults
set splitbelow
set splitright

" Buffers
" This allows buffers to be hidden if you've modified a buffer.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>t :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<cr>

" Move to the previous buffer
nmap <leader>h :bprevious<cr>

" Close the current buffer and move to the previous one
nmap <leader>q :bp <bar> bd #<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nerdtree
map <leader>n :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>
let g:NERDTreeHijackNetrw=0

" vim-airline
let g:airline_theme='tomorrow'
" disable tagline
let g:airline#extensions#tagbar#enabled = 1

" enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline_powerline_fonts=1

" Airline with Unicode (more portable)
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⬍'
" let g:airline_symbols.paste = '✂'
" let g:airline_symbols.whitespace = 'Ξ'

" Tabline looks better
let g:airline#extensions#tabline#enabled = 1

" Tcomment
" toggle comments with leader-c
map <leader>/ <c-_><c-_>


" ctrl-p
" add ctr-b as shortcut for buffer search
nnoremap <leader>b :CtrlPBuffer<CR>

" ignore some files and file types when indexing
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

" vim-test
let test#ruby#rspec#options = '--format documentation'
map <Leader>f :TestFile<CR>
map <Leader>t :TestNearest<CR>
map <Leader>r :TestLast<CR>
map <Leader>a :TestSuite<CR>

"incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" vim-markdown
let g:vim_markdown_folding_disabled=1

" syntastic
let g:syntastic_javascript_checkers = ['eslint']
