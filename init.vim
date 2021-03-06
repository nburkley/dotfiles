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

" Turn on spell checking
set spell

" Allow mouse with vim - scroll in vim, not in tmux buffer
set mouse=a

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
" set gfn=Source\ Code\ Pro\ for\ Powerline:h13
set gfn=Roboto\ Mono\ for\ Powerline:h13
" disable bold font
set t_md=

syntax enable " enable synax highlighting

set ruler               " turn on ruler
set number              " add line numbers
set nofoldenable        " Don't fold lines

" set line length marker to 120 by default 
set colorcolumn=120      " add line marker at 80 characters
" set line length marker to 80 for ruby files
au BufNewFile,BufRead *.rb setlocal colorcolumn=80

"
" Background colors for active vs inactive windows
hi ActiveWindow ctermbg=234
hi InactiveWindow ctermbg=235

" Dim inactive window when not in use
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
au VimEnter,WinEnter,BufEnter,BufWinEnter,FocusGained * hi ActiveWindow ctermbg=234 | hi InactiveWindow ctermbg=235
" Dim all both active and inactive windows when leaving vim (for another tmux pane)
au VimLeave,WinLeave,BufLeave,BufWinLeave,FocusLost * hi ActiveWindow ctermbg=235 | hi InactiveWindow ctermbg=235

" Display extra whitespace, tabs as », spaces as ·
set list listchars=tab:»·,trail:·,nbsp:·

" Allow cursor to change shape in different modes
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" show preiew of subsitutions before carrying out
set inccommand=nosplit

" try to improve scrolling
set lazyredraw

" Don't hide special characters
set conceallevel=0

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

" use jk as an alternative to Esc
inoremap jk <Esc>

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

" Enable Alt-backspace to delete words in insert mode
inoremap <C-b> <C-o>db<Cr>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reload files that have been changed elsewhere
" See: https://github.com/neovim/neovim/issues/2127
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup AutoSwap
  autocmd!
  autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

function! AS_HandleSwapfile (filename, swapname)
  " if swapfile is older than file itself, just get rid of it
  if getftime(v:swapname) < getftime(a:filename)
    call delete(v:swapname)
    let v:swapchoice = 'e'
  endif
endfunction
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
      \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

augroup checktime
  au!
  if !has("gui_running")
    "silent! necessary otherwise throws errors when using command
    "line window.
    autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
  endif
augroup END


"--------------------------------------------------------------
" PLUGINS
"--------------------------------------------------------------

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open NERDTree in the directory of the current file (or /home if no file is open)
" nmap <silent> <C-i> :call NERDTreeToggleInCurDir()<cr>
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction

map <leader>n :NERDTreeToggle<CR>     " Toggle nerdtree
map <leader>r :call NERDTreeToggleInCurDir()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" create Rg command for global search
nnoremap \ :Rg<SPACE>

" use fzf installation
set rtp+=/usr/local/opt/fzf
" Use rg with fzf
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

" Similarly, we can apply it to fzf#vim#grep.:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" when opening in a new split, put the new file right or below current file
set splitbelow splitright

" search files, but make sure they don't open in NERDtree
nnoremap <silent> <expr> <C-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
nnoremap <silent> <expr> <leader>p (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"

" search open buffers but make sure they don't open in NERDtree
nnoremap <silent> <expr> <leader>b (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Buffers\<cr>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set up some mappings to run tests groups using vim-test
map <Leader>f :TestFile<CR>
map <Leader>t :TestNearest<CR>
map <Leader>v :TestLast<CR>
map <Leader>a :TestSuite<CR>

" run tests in tmux pane below vim using vim-tmux-runner
let test#strategy = "vtr"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-commentary
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" comment out line in normal mode with <leader>/
nmap <leader>/ gcc
" comment out selected block in visual mode with <leader>/
vmap <leader>/ gc

" use # comments for terraform files
autocmd FileType terraform setlocal commentstring=#\ %s

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

" Call Elixir formatter on save for elixir files
autocmd BufWritePost *.exs silent :!mix format %
autocmd BufWritePost *.ex silent :!mix format %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyClip
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use 's' as a substitution operator
let g:EasyClipUseSubstituteDefaults=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" incsearch
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

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

" Let esc clear the last highlight search
nnoremap <esc> :noh<return><esc>

" Use leader setup search and replace
nmap <Leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

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

" Use indentLine to show indents because it doesn't mess with conceallevel

" Set it to use very minimal highlighting
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-pry
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" adds a language sensitive pry debug point
nmap <leader>d :call pry#insert()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tmux-navigator
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't navigate out of vim if tmux pane is zoomed
let g:tmux_navigator_disable_when_zoomed = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-alchimist
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:alchemist_tag_map = '<C-]>'
let g:alchemist_tag_stack_map = '<C-T>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nginx.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" detect nginx files and use correct syntax highlighting
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx

