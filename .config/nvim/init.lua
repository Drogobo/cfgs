vim.cmd([[
" BASIC STUFF
set linebreak
set showmatch			" show matching 
set ignorecase			" case insensitive 
set hlsearch			" highlight search 
set incsearch			" incremental search
set noexpandtab			" converts spaces to tabs
set autoindent			" indent a new line the same amount as the line just typed
set number			" add line numbers
syntax on			" syntax highlighting
syntax enable			" idk man
set mouse=a			" enable mouse click
set nocompatible		" not compatable
set noshowmode
set wildmode=longest,list,full " get bash-like tab completions
set clipboard=unnamedplus	" using system clipboard
filetype plugin on		" For plugs
set cursorline			" highlight current cursorline
set swapfile			" create swapfiles
set backupdir=~/.cache/vim	" Directory to store backup files.
set encoding=utf-8		" Encode with utf8
filetype plugin indent on	" Indents or sthing idk 
set splitbelow splitright	" Split opens at the bottom right
set completeopt=menu,menuone,noselect	" Auto completion stuff
set backspace=indent,eol,start
set termguicolors		"for terminal stuff.
function! GetUserInput()
	:set noexpandtab
	:retab!
	:%s/	/	/g
endfunction

" BINDINGS
imap <C-BS> <C-W>
nnoremap <F2> :call GetUserInput()<CR>
nnoremap <F3> :noh<CR>
nnoremap <F4> :NvimTreeToggle<CR>
nnoremap <C-H> b
nnoremap <C-L> w

" Bind arrows to move visual lines
nnoremap <Down> gj
nnoremap <Up> gk 
vnoremap <Down> gj
vnoremap <Up> gk

" PLUGINS
call plug#begin()
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
Plug 'mattn/emmet-vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'brenoprata10/nvim-highlight-colors'
Plug 'lambdalisue/suda.vim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
call plug#end()
]])

require('nvim-highlight-colors').setup {}
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
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})
