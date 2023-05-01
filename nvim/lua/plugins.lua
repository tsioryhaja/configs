
require("packer").startup(
	function()
		use 'wbthomason/packer.nvim'
		use 'neovim/nvim-lspconfig'
		use 'hrsh7th/cmp-nvim-lsp'
		use 'hrsh7th/cmp-buffer'
		use 'hrsh7th/nvim-cmp'
		use 'hrsh7th/vim-vsnip'
		use 'L3MON4D3/LuaSnip'
		use 'onsails/lspkind-nvim'
		use 'nvim-lualine/lualine.nvim'
--		use 'kyazdani42/nvim-tree.lua'
		use {
			'nvim-telescope/telescope.nvim',
			requires = {'nvim-lua/plenary.nvim' }
		}
		use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'
		use 'kyazdani42/nvim-web-devicons'
		use 'akinsho/bufferline.nvim'
		use 'glepnir/lspsaga.nvim'
		use 'lewis6991/gitsigns.nvim'
		use 'habamax/vim-godot'
		use 'preservim/nerdtree'
--		use 'noib3/nvim-cokeline'
		use 'mfussenegger/nvim-dap'
		use "rcarriga/nvim-dap-ui"
		use 'nvim-telescope/telescope-dap.nvim'
		use 'EdenEast/nightfox.nvim'
		use 'windwp/nvim-autopairs'
		use 'dinhhuy258/git.nvim'
		use 'stevearc/dressing.nvim'
    use 'gpanders/editorconfig.nvim'
    use 'kchmck/vim-coffee-script'
    use 'akinsho/git-conflict.nvim'
    use 'Mofiqul/vscode.nvim'
--    use 'xiyaowong/nvim-transparent'
	end
)

