"-"-"-"-" Grant Hernandez's .vimrc "-"-"-"-"

" Immediately disable Vi compatibility
set nocompatible

" Grab all the plugins. Sorry Vundle
execute pathogen#infect()

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

" Extra Syntaxes
augroup filetypedetect
  " Octave syntax
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END

" Gotta auto indent
filetype indent plugin on

" Buffers persist
set hidden

" Apparently speeds up some operations
set lazyredraw

" Better command-line completion
set wildmenu

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

" Enable use of the mouse for all modes
set mouse=a

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
" TODO: get this working with rxvt-unicode
"let g:airline_powerline_fonts = 1

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

" Useful mappings
cnoremap <C-a>  <Home>

" technically C-e not needed, but here for completeness
cnoremap <C-e>  <End>

" Mistakes
command Wq wq
command WQ wq
command Q q
command W w

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

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:airline#extensions#tabline#enabled = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" I hate seeing useless errors appear when I open files...
" Also speeds up file opening time
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/bin/python2'
" Way too big otherwise...
let g:syntastic_loc_list_height = 5

" CtrlP Customization
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
let g:ctrlp_working_path_mode = 'r'

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
" Selectively disable Syntastic
nnoremap <Leader>s :SyntasticToggleMode<CR>
" Shortcut for swapping header/source (using FSwitch)
nnoremap <Leader><Tab> :FSHere<CR>

" Spell check!
map <F5> :setlocal spell! spelllang=en_us<CR>
" Ctags list
map <F4> :TlistToggle<CR>
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Vim hardtime - not hardcore enough for this
" let g:hardtime_default_on = 1
" let g:hardtime_allow_different_key = 1
" let g:hardtime_maxcount = 4
" let g:hardtime_ignore_buffer_patterns = ["NERD.*"]
" let g:list_of_visual_keys = ["-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
