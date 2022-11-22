-- Checks and installs packer on any machine
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Reload neovim when every time this file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost setup.lua source <afile> | PackerSync
  augroup end
]])

-- Import packer + sanity check
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- Packer plugin list
local plugin_list = {

	-- Packer
	"wbthomason/packer.nvim",
	"nvim-lua/plenary.nvim",

	-- Basics
	"nvim-treesitter/nvim-treesitter",
	"numToStr/Comment.nvim",
	"windwp/nvim-autopairs",

	-- LSP
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",

	-- Autocomplete
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lsp",
	"onsails/lspkind.nvim",

	-- Snippets
	"SirVer/ultisnips",
	"quangnguyen30192/cmp-nvim-ultisnips",

	-- Latex
	"lervag/vimtex",

	-- File explorer
	"nvim-tree/nvim-tree.lua",

	-- Aesthetics
	"folke/tokyonight.nvim", -- colorscheme
	"nvim-lualine/lualine.nvim",
	"xiyaowong/nvim-transparent", -- transparency
	"lewis6991/gitsigns.nvim", -- git changes on signcolumn
	"kyazdani42/nvim-web-devicons", -- icons
	"lukas-reineke/indent-blankline.nvim", -- indentation guides
}

-- Install plugins with Packer
return packer.startup(function(use)
	-- Use every plugin
	for _, plugin in ipairs(plugin_list) do
		use(plugin)
	end

	-- Sync Packer
	if packer_bootstrap then
		require("packer").sync()
	end
end)
