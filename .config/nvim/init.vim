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
set completeopt=noinsert,menuone,noselect   " Auto completion stuff
autocmd BufEnter * call ncm2#enable_for_buffer()    " auto complete pls
" Plugins
call plug#begin()
Plug 'rust-lang/rust.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-tern'
call plug#end()
