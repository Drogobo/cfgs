" Regular stuff
set showmatch               " show matching 
set ignorecase              " case insensitive 
set hlsearch                " highlight search 
set incsearch               " incremental search
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set noexpandtab             " converts spaces to tabs
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
syntax on		    " syntax highlighting
syntax enable		    " idk man
scriptencoding utf-8	    " Encode utf8
set mouse=a                 " enable mouse click
set nocompatible	    " not compatable
set wildmode=longest,list,full " get bash-like tab completions
set clipboard=unnamedplus   " using system clipboard
filetype plugin on	    " For plugs
set cursorline              " highlight current cursorline
" set spell                 " enable spell check (may need to download language package)
set noswapfile              " disable creating swap file
set encoding=utf-8	    " Encode with utf8
set backupdir=~/.cache/vim  " Directory to store backup files.
filetype plugin indent on   " Indents or sthing idk 
set splitbelow splitright   " Split opens at the bottom right
set completeopt=menu,menuone,noselect   " Auto completion stuff
" Plugins
call plug#begin()
Plug 'ap/vim-css-color'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
Plug 'jreybert/vimagit'
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()
