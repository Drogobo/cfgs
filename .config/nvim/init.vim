" Regular stuff
set showmatch			" show matching 
set ignorecase			" case insensitive 
set hlsearch			" highlight search 
set incsearch			" incremental search
set noexpandtab			" converts spaces to tabs
set autoindent			" indent a new line the same amount as the line just typed
set number			" add line numbers
syntax on			" syntax highlighting
syntax enable			" idk man
scriptencoding utf-8		" Encode utf8
set mouse=a			" enable mouse click
set nocompatible		" not compatable
set noshowmode
set wildmode=longest,list,full " get bash-like tab completions
set clipboard=unnamedplus	" using system clipboard
filetype plugin on		" For plugs
set cursorline			" highlight current cursorline
" set spell			" enable spell check (may need to download language package)
set swapfile			" create swapfiles
set encoding=utf-8		" Encode with utf8
set backupdir=~/.cache/vim	" Directory to store backup files.
filetype plugin indent on	" Indents or sthing idk 
set splitbelow splitright	" Split opens at the bottom right
set completeopt=menu,menuone,noselect	" Auto completion stuff
set backspace=indent,eol,start
" FUN
function! GetUserInput()
	:set noexpandtab
	:retab!
	:%s/  /	/g
endfunction

" Cool Binds
imap <C-BS> <C-W>
nnoremap <F2> :call GetUserInput()<CR>
nnoremap <F3> :noh<CR>
nnoremap <C-H> b
nnoremap <C-L> w

" Plugins
call plug#begin()
Plug 'ap/vim-css-color'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
Plug 'mattn/emmet-vim'
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

lua << END
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'material',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'branch', 'diff', 'diagnostics'},
			lualine_c = {'filename'},
			lualine_x = {''},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {'filename'},
			lualine_x = {'location'},
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	}
END
