"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast quit without saving
nmap <leader>q :q!<cr>

" Disable middle button paste
:map <MiddleMouse> <Nop>
:imap <MiddleMouse> <Nop>

" Consecutive visual increment
vnoremap <C-a> g<C-a>
vnoremap g<C-a> <C-a>

"Remove all trailing whitespace by pressing F2
nnoremap <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

if exists(':tnoremap')
    " Disable Python 2 support
    let g:loaded_python_provider = 0
    " Disable Ruby support
    let g:loaded_ruby_provider = 0
    " Disable Node.js support
    let g:loaded_node_provider = 0
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins,
" :PlugInstall to install plugins, :PlugUpdate to update or install
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'michaeljsmith/vim-indent-object'
Plug 'terryma/vim-multiple-cursors'
Plug 'wincent/terminus'
Plug 'tpope/vim-repeat'
Plug 'valloric/youcompleteme'
Plug 'jiangmiao/auto-pairs'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'dylanaraps/wal.vim'
Plug 'sheerun/vim-polyglot'
Plug 'psliwka/vim-smoothie'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Neovim only
if exists(':tnoremap')
    Plug 'neomake/neomake'
endif

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Most commands support CTRL-T / CTRL-X / CTRL-V key bindings
" to open in a new tab, a new split, or in a new vertical split

" Current file directory
nnoremap <leader>- :FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>

" Search in current directory
nnoremap <leader>ff :FZF<cr>

" :Files [Path]
nnoremap <leader>fF :Files<cr>

" Open buffers
nnoremap <leader>b :Buffers<cr>

" Lines in loaded buffers
nnoremap <leader>fl :Lines<cr>

" Lines in the current buffer
nnoremap <leader>fb :BLines<cr>

" Tags in the project
nnoremap <leader>ft :Tags<cr>

" v:oldfiles and open buffers
nnoremap <leader>fh :History<cr>

" Helptags
nnoremap <leader>fH :Helptags<cr>

" Vim Command History
nnoremap <leader>f: :History:<cr>

" Search History
nnoremap <leader>f/ :History/<cr>

" Git files (git ls-files)
nnoremap <leader>fg :GFiles<cr>

" Git files (git status)
nnoremap <leader>fs :GFiles?<cr>

" Git commits (requires fugitive.vim)
nnoremap <leader>fc :Commits<cr>

" Vim Commands
nnoremap <leader>fv :Commands<cr>

" Change colorscheme
nnoremap <leader>fC :Colors<cr>

" Ripgrep search result (ALT-A to select all, ALT-D to deselect all)
nnoremap <leader>fr :Rg<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neomake
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MyOnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  elseif has('unix')
    return readfile('/sys/class/power_supply/AC0/online') == ['0']
  endif

  return 0
endfunction

" If on battery, run neomake automatically on write only, else, run on normal, read, write, and insert changes after 0.5s
if exists(':tnoremap')
    if MyOnBattery()
        call neomake#configure#automake('w')
    else
        call neomake#configure#automake('nrwi', 500)
    endif
endif

" Open error location list automatically
let g:neomake_open_list = 2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" Close vim if the only window left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  Yankstack
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load yankstack without default meta-p or meta-P bindings,
" use :Yank
let g:yankstack_map_keys = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  Save Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Line number and mouse point
set number
set mouse=a

" Clipboard set to global and ctrl c/v maps
" set clipboard=unnamedplus
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

vnoremap <leader>y "+y
vnoremap <leader>x "+c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Add a bit extra margin to the left
set foldcolumn=1

" Disable comment continuation
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Underline when going to insert mode
" autocmd InsertEnter,InsertLeave * set cul!

" Set cursor to thin line in insert mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif

" Linux: open browser with xdg-open using gx under cursor
let g:netrw_browsex_viewer= "xdg-open"

" Set windows to open below
set splitbelow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make color schemes work with highlights
function! AdaptColorscheme()
    highlight clear CursorLine
    highlight Normal ctermbg=none
    highlight LineNr ctermbg=none
    highlight Folded ctermbg=none
    highlight NonText ctermbg=none
    highlight SpecialKey ctermbg=none
    highlight VertSplit ctermbg=none
    highlight SignColumn ctermbg=none
endfunction

autocmd ColorScheme * call AdaptColorscheme()

" Enable syntax highlighting
syntax enable

" Set 256 color palette
set t_Co=256

try
    colorscheme wal
catch
endtry

set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :nohl<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Buffer movement and delete
map gb :bn<cr>
map gB :bp<cr>
map gd :bd<cr>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline status bar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1

" Enable Powerline fonts
let g:airline_powerline_fonts = 1

" The separator used on the left side
"let g:airline_left_sep = '>'

" The separator used on the right side
"let g:airline_right_sep = '<'

" Enable modified detection
let g:airline_detect_modified = 1

" Enable paste detection
let g:airline_detect_paste = 1

" Enable crypt detection
let g:airline_detect_crypt = 1

" Enable spell detection
let g:airline_detect_spell = 1

" Display spelling language when spell detection is enabled (if enough space is available)
let g:airline_detect_spelllang = 1

" Enable iminsert detection
let g:airline_detect_iminsert = 0

" Determine whether inactive windows should have the left section collapsed to only the filename of that buffer.
" let g:airline_inactive_collapse = 1

" Use alternative seperators for the statusline of inactive windows
" let g:airline_inactive_alt_sep = 1

" Themes are automatically selected based on the matching colorscheme. this can be overridden by defining a value.
" For powerline theme, need to manually add it to airline theme plugin folder
let g:airline_theme = 'powerlineish'

" Show warning and error counts returned by neomake#statusline#LoclistCounts
let g:airline#extensions#neomake#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    "set undodir=~/.vim_runtime/temp_dirs/undodir
    set undodir=~/.vim/undo
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set font according to system
if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
if exists('$TMUX')
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
