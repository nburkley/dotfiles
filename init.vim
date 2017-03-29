"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin managment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Usign vim-plug for plugin managment.
" Plugins and setup are contained in separate file, which should be 
" symlinked to ~/.config/nvim/plugins.vim
if filereadable(expand("~/.config/nvim/plugins.vim"))
  source ~/.config/nvim/plugins.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Share the clipboard outside of vim
set clipboard=unnamed

" Reload files if changed outside vim
set autoread

" don't use swap files
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" gruvbox contrast settting (needs to be done before setting the colorscheme
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox  " use gruvbox colorscheme
set background=dark  " use dark background

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look and feel
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set font to Source Code Pro, patched for Powerline, size 13
set gfn=Source\ Code\ Pro\ for\ Powerline:h13

syntax enable " enable synax highlighting

set ruler               " turn on ruler
set number              " add line numbers
set colorcolumn=80      " add line marker at 80 characters
set nofoldenable        " Don't fold lines

" Display extra whitespace, tabs as », spaces as ·
set list listchars=tab:»·,trail:·,nbsp:·

" NEOVIM SPECIFIC
"
" Allow cursor to change shape in different modes
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"
" show preiew of subsitutions before carrying out
set inccommand=nosplit

" try to improve scrolling
set lazyredraw


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows, bufferd & navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Buffers
" This allows buffers to be hidden if you've modified a buffer.
set hidden

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings and shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use space as leader key
let mapleader = " "

" Make arrowkey do something usefull, resize the viewports accordingly
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" remap Ctrl-s to save and exit insert
noremap  <c-s> :update<cr>
vnoremap <c-s> <c-c>:update<cr>
inoremap <c-s> <c-o>:update<cr><esc>

" ingore capital letters when saving quitting
cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Strip trailing whitespace, keeping cursor position
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Call StripTrailingWhitespaces on save for specific filetypes
autocmd BufWritePre *.rb,*.erb,*.html,*.css,*.scss,*.ex,*.exs,*.js,*.jsx :call <SID>StripTrailingWhitespaces()


"--------------------------------------------------------------
" PLUGINS
"--------------------------------------------------------------

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>n :NERDTreeToggle<CR>     " Toggle nerdtree
map <leader>r :NERDTreeFind<CR>       " Reval current file in nerdtree
let g:NERDTreeHijackNetrw=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" create Ag command for global search
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" bind \ to grep Ag shortcut
nnoremap \ :Ag<SPACE>

" use fzf installation
set rtp+=/usr/local/opt/fzf
" Use ag with fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" search files
nmap <silent> <leader>p :Files<CR>
" search open buffers
nmap <silent> <leader>b :Buffers<CR>

nnoremap <C-P> :Files<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <Leader>f :TestFile<CR>
map <Leader>t :TestNearest<CR>
map <Leader>v :TestLast<CR>
map <Leader>a :TestSuite<CR>
let test#strategy = "neoterm"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tcomment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" toggle comments with leader-/
map <leader>/ <c-_><c-_>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neomake
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set neomake verbosity level
let g:neomake_verbose = 0

" Use MRI ruby and rubocop to enforce rules for ruby
let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1

let g:neomake_elixir_enabled_makers = ['mix']

augroup localneomake
  autocmd! BufWritePost * Neomake
augroup END

 " Configure a nice credo setup, courtesy
" https://github.com/neomake/neomake/pull/300
let g:neomake_elixir_enabled_makers = ['mycredo']
function! NeomakeCredoErrorType(entry)
  if a:entry.type ==# 'F'      " Refactoring opportunities
    let l:type = 'W'
  elseif a:entry.type ==# 'D'  " Software design suggestions
    let l:type = 'I'
  elseif a:entry.type ==# 'W'  " Warnings
    let l:type = 'W'
  elseif a:entry.type ==# 'R'  " Readability suggestions
    let l:type = 'I'
  elseif a:entry.type ==# 'C'  " Convention violation
    let l:type = 'W'
  else
    let l:type = 'M'           " Everything else is a message
  endif
  let a:entry.type = l:type
endfunction

let g:neomake_elixir_mycredo_maker = {
      \ 'exe': 'mix',
      \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
      \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
      \ 'postprocess': function('NeomakeCredoErrorType')
      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyClip
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use 's' as a substitution operator
let g:EasyClipUseSubstituteDefaults=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" incsearch
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Let esc clear teh last highlight search
nnoremap <esc> :noh<return><esc>

" Use leader setup search and replace
nmap <Leader>s :%s//gc<Left><Left><Left>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-easy-align
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable omni syntax completion
set omnifunc=syntaxcomplete#Complete

" Deoplete, autocomplete
let g:deoplete#enable_at_startup = 1
  " use tab for completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" indent line color
let g:indentLine_setColors = 1
let g:indentLine_color_term = 237


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-pry
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>d :call pry#insert()<cr>

