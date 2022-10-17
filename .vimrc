" ====================================================================================
" SETUP NOTES
" ====================================================================================

"----------------------------------- CLANG / ALE -------------------------------------

" sudo apt install clang-formatter to ensure clang-formatter can be called from Ale

"----------------------------------- FLAKE8 / ALE ------------------------------------

" pip3 install flake8 to ensure flake8 runs with ALE
" Adjust global max line length by adding to ~/.config/flake8:
" [flake8]
" max-line-length = 88

"-------------------------------------- BLACK ----------------------------------------

" sudo apt-get install python3-venv to ensure black can install

"------------------------------------- VIM PLUG --------------------------------------

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" to install vim-plug

" vim --> :PlugInstall from within vim instance to actually install plugins

" ====================================================================================
" CORE SETTINGS
" ====================================================================================

" General
set nocompatible              " be iMproved, required
filetype off                  " required
set exrc

" Encodings
set encoding=utf-8
set fileencoding=utf-8

" Disable swap files
set noswapfile
set nobackup
set nowb

" Set persistent undo (store undo across sessions)
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ====================================================================================
" VIM PLUG
" ====================================================================================

" Initialize vim-plug
call plug#begin('~/.vim/plugged')

"-------------------------------- SYNTAX HIGHLIGHTING --------------------------------

" Polyglot
Plug 'sheerun/vim-polyglot'

" Vim Rainbow
Plug 'frazrepo/vim-rainbow'

"---------------------------------- AUTO COMPLETION ----------------------------------

" UltiSnips
Plug 'SirVer/ultisnips'

" Auto Pairs
Plug 'jiangmiao/auto-pairs'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Emmet
Plug 'mattn/emmet-vim'

"------------------------------------ FORMATTING ------------------------------------

" ALE
Plug 'dense-analysis/ale'

" Python Black
Plug 'psf/black', { 'branch': 'stable' }

"-------------------------------------- SEARCH ---------------------------------------

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"-------------------------------------- VIM UI ---------------------------------------

" Gruvbox
Plug 'morhetz/gruvbox'

" Vim Airline
Plug 'vim-airline/vim-airline'

" NERDTree
Plug 'preservim/nerdtree'

"---------------------------------------- GIT ----------------------------------------

" Git gutter
Plug 'airblade/vim-gitgutter'

" Vim fugitive
Plug 'tpope/vim-fugitive'

"------------------------------------- MARKDOWN --------------------------------------

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Uninitialize vim-plug
call plug#end()

" ====================================================================================
" POLYGLOT SETTINGS
" ====================================================================================

let g:python_highlight_space_errors = 0

" ====================================================================================
" ULTISNIPS SETTINGS
" ====================================================================================

" Trigger configuration
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ====================================================================================
" COC SETTINGS
" ====================================================================================

" Add TypeScript server
let g:coc_global_extensions = ['coc-tsserver']

" ====================================================================================
" ALE SETTINGS
" ====================================================================================

let g:ale_linters = {
\    'python': ['flake8'],
\    }
let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\    'c': ['clang-format'],
\    'haskell': ['brittany'],
\    'html': ['prettier'],
\    'javascript': ['prettier', 'eslint'],
\    'python': [],
\    'scss': ['prettier'],
\    'typescript': ['prettier', 'eslint'],
\    'typescriptreact': ['prettier', 'eslint'],
\}

let g:ale_python_flake8_options = '--max-line-length 88'

let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_executable='npx eslint'
let g:ale_javascript_prettier_options = '--print-width 88'

let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'

" ====================================================================================
" RAINBOW SETTINGS
" ====================================================================================

let g:rainbow_active = 1

" Disable Rainbow for HTML (breaks highlighting)
let g:rainbow_load_separately = [
    \ [ '*.{html,htm}' , [] ],
\ ]

" ====================================================================================
" PYTHON BLACK SETTINGS
" ====================================================================================

" Ensure that Black runs on save
" Note: This uses Black as a vim dep rather than through ALE
" Black is much quicker this way rather than as a fixer
autocmd BufWritePre *.py execute ':Black'

" ====================================================================================
" NERDTREE SETTINGS
" ====================================================================================

" Remap NERDTree toggle
map <C-t> :NERDTreeToggle<CR>

" Open NERDTree automatically when vim starts
autocmd vimenter * NERDTree | wincmd p

" Configure tree settings
let NERDTreeShowHidden = 1
let g:NERDTreeDirArrows = 0
let g:NERDTreeNodeDelimiter = "\u00a0"

" Close vim if NERDTree is the only remaining window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Define NERDTree ignore
let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store']

" ====================================================================================
" FZF SETTINGS
" ====================================================================================

" Remap Files command
nnoremap <C-f> :Files<Cr>

" Remap grep command
nnoremap <C-g> :Rg<Cr>

" ====================================================================================
" MARKDOWN PREVIEW SETTINGS
" ====================================================================================

" Open markdown preview automatically
let g:mkdp_auto_start = 1

" ====================================================================================
" VIM SETTINGS
" ====================================================================================

" Key mappings
imap ii <Esc>
inoremap ;; <C-o>A;

" Interface settings
set number
set ruler
set hidden
set autoread
set history=1000
let &colorcolumn = "88"

" Syntax settings
syntax enable

" Theme settings
colorscheme gruvbox
set termguicolors
set background=dark

" Window settings
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

" Disable auto-comment on next line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable secure mode
set secure

" ====================================================================================
" FILE SPECIFIC MAPPINGS
" ====================================================================================

" C Mappings
autocmd FileType c nnoremap <F8> :w <CR> :!gcc % -o %< && ./%< <CR>

" Haskell Mappings
autocmd FileType haskell nnoremap <F8> :w <CR> :!ghc -o %< % && ./%< <CR>

" ====================================================================================
" RESOURCES
" ====================================================================================

" https://github.com/jamessingizi/vim-setup/blob/master/.vimrc
" https://github.com/victormours/dotfiles/blob/master/vim/vimrc
" https://github.com/ayoisaiah/dotfiles/blob/master/vim/general.vim
" https://github.com/sebbekarlsson/i3/blob/master/.vimrc
