return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'nvim-lualine/lualine.nvim'
	use 'tpope/vim-surround'
	use 'rust-lang/rust.vim'
	use 'mattn/emmet-vim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'brenoprata10/nvim-highlight-colors'
	use 'lambdalisue/suda.vim'
	use 'kyazdani42/nvim-tree.lua'
	use 'kyazdani42/nvim-web-devicons'
	use 'othree/html5.vim'
	use 'pangloss/vim-javascript'
	use 'evanleck/vim-svelte'
	use 'mattn/webapi-vim'
	if packer_bootstrap then
		require('packer').sync()
	end
end)
