"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader=","

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

" Remove all trailing whitespace by pressing F2
nnoremap <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Move highlighted section up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Quickly insert an empty new line without entering insert mode, below and above
nnoremap <space>o o<Esc>k
nnoremap <space>O O<Esc>j

" Quickly add spacing between functions and insert in the middle
nnoremap <leader>o o<Esc>ko

if exists(':tnoremap')
    " Disable Python 2 support
    let g:loaded_python_provider=0
    " Disable Ruby support
    let g:loaded_ruby_provider=0
    " Disable Node.js support
    let g:loaded_node_provider=0
endif

" Turn error bell off
set noerrorbells

" Relative linenumbers
set relativenumber

" Set paste by default
set paste

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
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'michaeljsmith/vim-indent-object'
Plug 'terryma/vim-multiple-cursors'
Plug 'wincent/terminus'
Plug 'tpope/vim-repeat'
Plug 'valloric/listtoggle'
Plug 'dylanaraps/wal.vim'
Plug 'morhetz/gruvbox'
Plug 'phanviet/vim-monokai-pro'
Plug 'sheerun/vim-polyglot'
Plug 'psliwka/vim-smoothie'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-rooter'
Plug 'tmsvg/pear-tree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }         "Need NodeJS and Yarn
Plug 'honza/vim-snippets'
Plug 'nvim-treesitter/nvim-treesitter'                                          "Requires neovim-nightly

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COC.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms=4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" inoremap <silent><expr> <TAB>
"             \ pumvisible() ? "\<C-n>" :
"             \ <SID>check_back_space() ? "\<TAB>" :
"             \ coc#refresh()

function! s:check_back_space() abort
    let col=col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()
"Some terminals may send <NUL> when you press <c-space>, so you could instead:
" inoremap <silent><expr> <NUL> coc#refresh()

" Close completition window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>S  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Extensions
" coc config
let g:coc_global_extensions=['coc-sh', 'coc-json', 'coc-rust-analyzer', 'coc-css',
            \ 'coc-markdownlint', 'coc-yank', 'coc-clangd', 'coc-omnisharp',
            \ 'coc-cmake', 'coc-go', 'coc-snippets', 'coc-pyright']

" View yank list from coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Format selected text
vmap <leader>p  <Plug>(coc-format-selected)
nmap <leader>p  <Plug>(coc-format-selected)

" Snippets

" Use <tab> for jump to next placeholder
let g:coc_snippet_next='<tab>'

" Use Shift + <tab> for jump to previous placeholder
let g:coc_snippet_prev='<S-tab>'

" Use location list of CocList when jump to locations
let g:coc_enable_locationlist=1

" Change background of floating window to a darker color (gets overwritten by colorscheme)
" highlight Pmenu ctermfg=NONE ctermbg=2 cterm=NONE guifg=NONE guibg=#64666d gui=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Most commands support CTRL-T / CTRL-X / CTRL-V key bindings
" to open in a new tab, a new split, or in a new vertical split

" Current file directory
nnoremap <leader>- :FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>
" Search in current directory
nnoremap <leader>ff :FZF<cr>
" Search home directory
nnoremap <leader>fF :Files ~/<cr>
" Open buffers
nnoremap <leader>fb :Buffers<cr>
" Lines in loaded buffers
nnoremap <leader>fl :Lines<cr>
" Lines in the current buffer
nnoremap <leader>fB :BLines<cr>
" Tags in the project
nnoremap <leader>ft :Tags<cr>
" v:oldfiles and open buffers
nnoremap <leader>fh :History<cr>
" Help tags
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
" View marks
nnoremap <leader>fm :Marks<cr>
" Ripgrep search result (ALT-A to select all, ALT-D to deselect all)
nnoremap <leader>fr :Rg<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nvim-treesitter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  refactor = {
    highlight_definition = { enable = true },
    navigation = { enable = true },
  },
  textobjects = { enable = true },
}
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git status
nmap <leader>gs :G<CR>

" For merge conflicts, 2=left, 3=right
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ListToggle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle for location list and quickfix
let g:lt_location_list_toggle_map='<leader>l'
let g:lt_quickfix_list_toggle_map='<leader>L'

" Set height
" let g:lt_height=10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos="right"
let NERDTreeShowHidden=0
let NERDTreeIgnore=['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" Close vim if the only window left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Rooter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change directory for non-project files to current file directory
let g:rooter_change_directory_for_non_project_files='current'

" Resolve Symbolic Links
let g:rooter_resolve_links=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pear Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default rules for matching:
let g:pear_tree_pairs={
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
            \ '<': {'closer': '>', 'not_at': ['\s']}
            \}
" See pear-tree/after/ftplugin/ for filetype-specific matching rules

" Pear Tree is enabled for all filetypes by default:
let g:pear_tree_ft_disabled=[]

" Pair expansion is dot-repeatable by default:
let g:pear_tree_repeatable_expand=1

" Turn on smart pairing
let g:pear_tree_smart_openers=1
let g:pear_tree_smart_closers=0
let g:pear_tree_smart_backspace=1

" If enabled, smart pair functions timeout after 60ms:
let g:pear_tree_timeout=60

" Automatically map <BS>, <CR>, and <Esc>
let g:pear_tree_map_special_keys=0

" Default mappings:
imap <BS> <Plug>(PearTreeBackspace)
" imap <CR> <Plug>(PearTreeExpand)
" imap <Esc> <Plug>(PearTreeFinishExpansion)
" Pear Tree also makes <Plug> mappings for each opening and closing string.
"     :help <Plug>(PearTreeOpener)
"     :help <Plug>(PearTreeCloser)

" Move cursor past closing string
imap <C-j> <Plug>(PearTreeJump)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown Preview
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start=0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close=1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow=0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be used in markdown file
" default: 0
let g:mkdp_command_for_global=0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world=0

" specify browser to open preview page
" default: ''
let g:mkdp_browser='brave'

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
let g:mkdp_preview_options={
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title='「${name}」'

" Preview Mappings
nmap <leader>md <Plug>MarkdownPreviewToggle

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
    let &t_SI="\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI="\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI="\e[5 q"
    let &t_EI="\e[2 q"
endif

" Linux: open browser with xdg-open using gx under cursor
let g:netrw_browsex_viewer="xdg-open"

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
    highlight CursorLineNr ctermbg=none
endfunction

autocmd ColorScheme * call AdaptColorscheme()

" Enable syntax highlighting
syntax enable

" Set 256 color palette
set t_Co=256

try
    colorscheme gruvbox
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

" Make it so that a curly brace automatically inserts an indented line
" Use this instead of pear-tree because it does not mess up undo
inoremap {<CR> {<CR>}<Esc>O<BS><Tab>

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

" Buffer next, previous, delete and switch to last open buffer
map gb :bn<cr>
map gB :bp<cr>
map <leader>bd :bd<cr>
map g<tab> :b#<cr>

" Save current buffer and close all other buffers
map <silent> <leader>ba :w<cr>:%bd<cr>:e#<cr>:bd#<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neovim Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists(':tnoremap')
    " Use <C-w> in terminal mode to escape all the way
    tnoremap <C-w> <C-\><C-n><C-w>

    " With this function you can reuse the same terminal in neovim.
    " You can toggle the terminal and also send a command to the same terminal.
    " Taken and modified from: https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23
    let s:monkey_terminal_window=-1
    let s:monkey_terminal_buffer=-1
    let s:monkey_terminal_job_id=-1
    let s:monkey_terminal_current_dir=""

    function! MonkeyTerminalOpen()
        " Check if buffer exists, if not create a window and a buffer
        if !bufexists(s:monkey_terminal_buffer)
            " Creates a window call monkey_terminal
            new monkey_terminal
            " Moves to the window below the current one
            wincmd J
            let s:monkey_terminal_job_id=termopen($SHELL, { 'detach': 1 })

            " Change the name of the buffer to "Terminal 1"
            silent file Terminal\ 1
            " Gets the id of the terminal window
            let s:monkey_terminal_window=win_getid()
            let s:monkey_terminal_buffer=bufnr('%')
            let s:monkey_terminal_current_dir=getcwd()

            " The buffer of the terminal won't appear in the list of the buffers
            " when calling :buffers command
            set nobuflisted
        else
            if !win_gotoid(s:monkey_terminal_window)
                sp
                " Moves to the window below the current one
                wincmd J
                buffer Terminal\ 1
                " Gets the id of the terminal window
                let s:monkey_terminal_window=win_getid()

                "Change project directory to current buffer's project directory (requires vim-rooter)
                if s:monkey_terminal_current_dir != getcwd()
                    let s:monkey_terminal_current_dir=getcwd()
                    call chansend(s:monkey_terminal_job_id, "cd ")
                    call chansend(s:monkey_terminal_job_id, s:monkey_terminal_current_dir)
                    call chansend(s:monkey_terminal_job_id, "\n")
                endif
            endif
        endif
    endfunction

    function! MonkeyTerminalToggle()
        if win_gotoid(s:monkey_terminal_window)
            call MonkeyTerminalClose()
        else
            " Resize terminal window to be 1/3 of main window
            let s:main_window_height=winheight(0) * 1/3
            call MonkeyTerminalOpen()
            exe 'resize' s:main_window_height
        endif
    endfunction

    function! MonkeyTerminalClose()
        if win_gotoid(s:monkey_terminal_window)
            " close the current window
            hide
        endif
    endfunction

    " Toggle the terminal with alt + enter
    nnoremap <silent> <M-cr> :call MonkeyTerminalToggle()<cr>a
    inoremap <silent> <M-cr> <Esc>:call MonkeyTerminalToggle()<cr>a
    tnoremap <silent> <M-cr> <C-\><C-n>:call MonkeyTerminalToggle()<cr>
endif

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
let g:airline#extensions#tabline#enabled=1

" Enable Powerline fonts
let g:airline_powerline_fonts=1

" The separator used on the left side
"let g:airline_left_sep='>'

" The separator used on the right side
"let g:airline_right_sep='<'

" Enable modified detection
let g:airline_detect_modified=1

" Enable paste detection
let g:airline_detect_paste=1

" Enable crypt detection
let g:airline_detect_crypt=1

" Enable spell detection
let g:airline_detect_spell=1

" Display spelling language when spell detection is enabled (if enough space is available)
let g:airline_detect_spelllang=1

" Enable iminsert detection
let g:airline_detect_iminsert=0

" Determine whether inactive windows should have the left section collapsed to only the filename of that buffer.
" let g:airline_inactive_collapse=1

" Use alternative seperators for the statusline of inactive windows
" let g:airline_inactive_alt_sep=1

" Themes are automatically selected based on the matching colorscheme. this can be overridden by defining a value.
" For powerline theme, need to manually add it to airline theme plugin folder
let g:airline_theme='powerlineish'

" Enable/disable COC.nvim error/warning display
" let g:airline#extensions#coc#enabled=0

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
