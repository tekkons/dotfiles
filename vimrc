" Basic Behavior
set number                " show line numbers
set autoread              " watch for file changes
set wrap                  " wrap lines
set encoding=utf-8        " set encoding to UTF-8 (default was 'latin1')
set showcmd               " show selection metadata
set showmode              " show INSERT, VISUAL, etc. mode
set showmatch             " highlight matching parentheses / brackets [{()}]
set smarttab              " better backspace and tab functionality
set scrolloff=20          " show at least 20 line above/below
set ignorecase            " ignoring case in a pattern
set smartcase             " search pattern contains upper case characters
set clipboard=unnamedplus " paste a selection from another application
set noswapfile            " loaded without creating a swapfile

" Tab settings
set autoindent            " copy indent from current line when starting a new line
set smartindent           " even better autoindent (e.g. add indent after '{')
set expandtab             " convert <TAB> key-presses to spaces
set tabstop=2             " width that a <TAB> character displays as
set shiftwidth=2          " number of spaces to use for each step of (auto)indent
set softtabstop=2         " backspace after pressing <TAB> will remove up to this many spaces

" Search settings
set incsearch             " search as characters are entered
set hlsearch              " highlight matches

" Vim Appearance
syntax on
filetype on
filetype indent on
filetype plugin on

" Key Bindings
nmap nm :set nonumber<CR>
nmap mn :set number<CR>

