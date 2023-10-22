-- BASIC STUFF
vim.cmd('set linebreak')
vim.cmd('set showmatch')				-- show matching
vim.cmd('set ignorecase')				-- case insensitive
vim.cmd('set hlsearch')					-- highlight search
vim.cmd('set incsearch')				-- incremental search
vim.cmd('set autoindent')				-- indent a new line the same amount as the line just typed
vim.cmd('set number')					-- add line numbers
vim.cmd('syntax enable')				-- enable syntax highlighting
vim.cmd('set mouse=')					-- disable mouse
vim.cmd('set nocompatible')				-- not compatible
vim.cmd('set noshowmode')
vim.cmd('set wildmode=longest,list,full')		-- get bash-like tab completions
vim.cmd('set clipboard=unnamedplus')			-- using system clipboard
vim.cmd('filetype plugin on')				-- For plugins
vim.cmd('set cursorline')				-- highlight the current cursor line
vim.cmd('set swapfile')					-- create swap files
vim.cmd('set backupdir=~/.cache/nvim')			-- Directory to store backup files.
vim.cmd('set encoding=utf-8')				-- Encode with UTF-8
vim.cmd('filetype plugin indent on')			-- Enable indenting for different file types
vim.cmd('set splitbelow')				-- Split opens at the bottom
vim.cmd('set splitright')
vim.cmd('set completeopt=menu,menuone,noselect')	-- Auto-completion options
vim.cmd('set backspace=indent,eol,start')
vim.cmd('set termguicolors')				-- For terminal stuff
vim.opt.tabstop = 4					-- Set the width of a tabstop (number of spaces)
vim.opt.shiftwidth = 4					-- Set the width of an indent (number of spaces)
vim.opt.expandtab = false					-- Use tabs instead of spaces
vim.cmd('autocmd FileType * setlocal noexpandtab')
vim.o.expandtab = false

-- PLUGINS
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

require('plugins')
vim.cmd([[
  augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
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
		lualine_x = {'filetype'},
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

-- CUSTOM FUNCTIONS
function repeat_action()
	local action = vim.fn.input("Enter the action to repeat: ")
	if action == "" or action == nil then
		print("No action entered. Aborting.")
		return
	end
	action = "normal! " .. action

	local count = vim.fn.input("Enter the number of times to repeat the action: ")
	count = tonumber(count)
	if not count or count <= 0 then
		print("Invalid input. Please enter a valid number.")
		return
	end

	for i = 1, count do
		vim.cmd(action)
	end

	print("Action repeated " .. count .. " times.")
end

function spaces_to_tabs()
	local num_spaces = vim.fn.input("Enter the number of spaces to replace with tabs: ")
	vim.cmd("redraw") -- Clear the command line
	if num_spaces == nil or num_spaces == '' then
		vim.cmd("echo 'No input provided. Aborting.'")
		return
	end

	local spaces_to_replace = string.rep(' ', tonumber(num_spaces))
	local current_line = vim.fn.getline(1)
	local new_line = vim.fn.substitute(current_line, spaces_to_replace, '\t', 'g')
	vim.fn.setline(1, new_line)

	for line_number = 2, vim.fn.line('$') do
		current_line = vim.fn.getline(line_number)
		new_line = vim.fn.substitute(current_line, spaces_to_replace, '\t', 'g')
		vim.fn.setline(line_number, new_line)
	end

	vim.cmd("echo 'Spaces replaced with tabs.'")
end

-- BINDINGS
vim.api.nvim_set_keymap('n', '<F5>', ':lua repeat_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-W>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F2>', ':lua spaces_to_tabs()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F3>', ':noh<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F4>', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-H>', 'b', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-L>', 'w', { noremap = true })

-- VIM ELITISM
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Right>', '<Nop>', { noremap = true, silent = true })
