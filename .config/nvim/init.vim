set showmatch               " show matching 
set ignorecase              " case insensitive 
set hlsearch                " highlight search 
set incsearch               " incremental search
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set noexpandtab             " converts spaces to tabs
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set wildmode=longest,list   " get bash-like tab completions
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
" set spell                 " enable spell check (may need to download language package)
set noswapfile              " disable creating swap file
set backupdir=~/.cache/vim  " Directory to store backup files.
filetype plugin indent on   " Indents or sthing idk 

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>
" Splits open at the bottom and right, which is smart, unlike vim defaults.
	set splitbelow splitright   
call plug#begin()
Plug 'rust-lang/rust.vim'
call plug#end()
