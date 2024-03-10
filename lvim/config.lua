local icons = require "icons"
-- lvim stuff
lvim.log.level = "warn"
lvim.format_on_save.enabled = true

lvim.transparent_window = true
vim.opt.termguicolors = true
lvim.transparent_window = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
}

lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
    { 'catppuccin/nvim' },
    { 'Mofiqul/dracula.nvim' },
    { 'folke/tokyonight.nvim' },
    { 'lervag/vimtex' },
    { 'hrsh7th/cmp-omni' },
    { 'KeitaNakamura/tex-conceal.vim' },
    { 'kaicataldo/material.vim' },
    { 'shaunsingh/nord.nvim' },
    { 'tanvirtin/monokai.nvim' },
    { 'navarasu/onedark.nvim' },
    { 'sirver/ultisnips' },
    { 'quangnguyen30192/cmp-nvim-ultisnips' },
    { 'onsails/lspkind.nvim' },
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- configuration goes here
        },
    },
    { 'preservim/vim-pencil' }
}

-- Vimtex for note-taking
vim.g.tex_flavor = 'latex'
vim.g.vimtex_compiler_latexmk = {
    out_dir = 'build',
}
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quick_fix_enabled = 0
vim.g.vimtex_quickfix_open_on_warning = 0
-- vim.opt.conceallevel = 1
vim.g.tex_conceal = 'abdmg'


-- nvim-cmp settings
require('tex-ultisnips-cmp')

-- require("notify").setup({
--     background_colour = "#000000",
-- })
