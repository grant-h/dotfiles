"-"-"-"-" Grant Hernandez's .vimrc "-"-"-"-"

" Immediately disable Vi compatibility
set nocompatible

" Grab all the plugins. Goodbye pathogen
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""""""""""""""""""
" PLUGIN LIST
""""""""""""""""""""""""
call plug#begin('~/.vim/vplug')

" Status and navigation
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'danro/rename.vim'

" Sets buffer values 'intelligently'
" Plug 'tpope/vim-sleuth'

" Syntax and command helpers
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'
Plug 'ajh17/VimCompletesMe'

" Syntax specific
Plug 'leafgarland/typescript-vim'
Plug 'tikhomirov/vim-glsl'
Plug 'pangloss/vim-javascript'
Plug 'derekwyatt/vim-scala'
Plug 'Shirk/vim-gas'
Plug 'heavenshell/vim-pydocstring'

" Fullscreen writing
Plug 'junegunn/goyo.vim'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""
" CONFIGURATION
""""""""""""""""""""""""

" Get rid of splash screen
set shortmess+=I

" Have a sane leader
let mapleader = "\<space>"

" Color scheme
"colorscheme think_dark
colorscheme sweylapurp

" Indentation settings
set shiftwidth=2
set softtabstop=2
set expandtab

" Syntax Options
syntax on

" Operating system specific commands
if has('unix')
  if has('mac')       " osx
    " TODO: also search for ITERM env variables
    " iTerm2 cursor changes per mode
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  else                " linux, bsd, etc
  endif
elseif has('win32') || has('win64')
endif

" Extra Syntaxes
augroup filetypedetect
  " Octave syntax
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
  " EJS syntax
  au! BufRead,BufNewFile *.ejs set filetype=html
  " Svelte
  au! BufRead,BufNewFile *.svelte set filetype=html
  " Javascript ES6
  au! BufRead,BufNewFile *.cjs,*.mjs set filetype=javascript
  " GNU AS syntax (from Shirk/vim-gas)
  au! BufRead,BufNewFile *.S,*.s set filetype=gas
augroup END

" https://github.com/pangloss/vim-javascript

augroup spell_checking
    au!
    au FileType tex,plaintex setlocal spell! spelllang=en_us
    au FileType tex,plaintex setlocal spellfile=~/.vim/spell/en.utf-8.tex.add
augroup END


" Gotta auto indent
filetype indent plugin on

" Buffers persist
set hidden

" Apparently speeds up some operations
set lazyredraw
" But at the cost of not having a status line on entering vim...
autocmd VimEnter * redraw!

" Better command-line completion
set wildmenu
" Wild menu ignore files
set wildignore+=*.o,*.aux,.git,*.log,*.exe,*.out

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <Leader-L> to reset search turn off highlighting)
set hlsearch

" Undo support \o/
set undofile
set undodir=~/.vim/undo-files/

" Except for getting tabbing/spacing right, meh
set nomodeline

" Case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Prevents ViM from breaking in the middle of a word
set linebreak

" Show a horizontal line where the cursor is
set cursorline

" Allows the clipboard to work on MacOS (note you need ViM 7.4 or greater)
set clipboard=unnamed

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Status line covered by plugins
set statusline=

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Seizure prevention
set t_vb=

" Disable MacVim/GVim audible bell
autocmd! GUIEnter * set vb t_vb=

" Enable use of the mouse for all modes
set mouse=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Set the command window height to 2 lines
set cmdheight=2

" Display line numbers on the left
set number
set relativenumber

" Quickly time out on keycodes, but never time out on mappings
" Gotta go fast
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
" BUG: pasting things with <Leader>p will exit paste mode :(
" set pastetoggle=<Leader>p
set pastetoggle=<F11>

" Listchars for showing tabs and trailing whitespace
set list

" Danger: unicode ahead
set listchars=tab:\|⋅,trail:⋅,nbsp:⋅
"set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'

" Checking for vimpager/vimmanpager
if has("eval") && has("autocmd")
  fun! <SID>check_pager_mode()
    if exists("g:loaded_less") && g:loaded_less
      " we're in vimpager / less.sh / man mode
      set laststatus=0
      set ruler
      set foldmethod=manual
      set foldlevel=99
      set scrolloff=999
      set nolist
      set nonumber
      set norelativenumber
    endif
  endfun
  autocmd VimEnter * :call <SID>check_pager_mode()
endif

" ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
" Mappings
" - - - - - - - - - - - - - - - -

" Prevent me from being stupid (no longer needed)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Make j + k sane
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Quick and easy ESC key. Disabled ESC key 
inoremap jk <ESC>
inoremap kj <ESC>

" Disable F1 in insert mode and make it escape
inoremap <F1> <Esc>
noremap <F1> :call MapF1()<CR>

function! MapF1()
  if &buftype == "help"
    exec 'quit'
  else
    exec 'help'
  endif
endfunction

noremap <C-w><C-w> <C-w><C-p>

" Useful mappings
cnoremap <C-a>  <Home>

" technically C-e not needed, but here for completeness
cnoremap <C-e>  <End>

" Mistakes
command! Wa wa
command! WA wa
command! Wq wq
command! WQ wq
command! Qa qa
command! QA qa
command! Q q
command! W w
" We dont care about Vim encryption, just quicksaving

" set these to your terminal defaults for Arrow-L and Arrow-R
" may fail if the first command out of command editing mode is 'O'
" (compatible with urxvt)
cnoremap <Esc>Oc <S-right>
cnoremap <Esc>Od <S-left>

" enable if you want to mask normal C-f behavior
"cnoremap <C-b>  <Left>
"cnoremap <C-f>  <Right>
"cnoremap <C-d>  <Delete>
" not needed if correct urxvt options set
"cnoremap <C-bs> <C-w>

" quick keyboard switching of windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

let g:airline#extensions#tabline#enabled = 1

" CtrlP Customization
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|node_modules)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
let g:ctrlp_working_path_mode = 'r'

" If rg (ripgrep) is found in the path, use it to improve CtrlP
if executable("rg") == 1
  let g:ctrlp_user_command = ['.git', 'cd %s && rg --files-with-matches ".*"', 'find %s -type f']
endif

" Goyo customization
let g:goyo_width = 120

function! s:goyo_enter()
  set showtabline=2
  set noshowmode
endfunction

function! s:goyo_leave()
  set showmode
  " Goyo messes up the theme :(
  AirlineTheme bubblegum
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Better buffer handling
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

" Map <Leader><C-L> to also turn off search highlighting until the
" next search
nnoremap <Leader>l :nohl<CR>:redraw!<CR>
" Quick access to CtrlP
nnoremap <Leader><Leader> :CtrlP<CR>
" NERDTree pane
nnoremap <Leader>t :NERDTreeToggle<CR>
" Tab between buffers
nnoremap <Tab><Tab> :e#<cr>
" Shortcut for swapping header/source (using FSwitch)
nnoremap <Leader><Tab> :FSHere<CR>
" LaTeX Skim forward search
map <Leader>j :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')<CR> %<.pdf %<CR><CR>

" Spell check!
map <F5> :setlocal spell! spelllang=en_us<CR>
" Ctags list
map <F4> :TlistToggle<CR>
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

augroup javascript_indent
    au!
    au FileType javascript setlocal foldmethod=manual
    au FileType javascript set noexpandtab shiftwidth=4 ts=4
augroup END
