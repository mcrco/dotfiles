-- lvim stuff
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.format_on_save = {
  pattern = "*.java", "*.lua", "*.python", "*.js", "*.snippets"
}

-- theme
require("tokyonight-theme")
-- lvim.colorscheme = "tokyonight"
lvim.transparent_window = true
vim.opt.termguicolors = true
lvim.transparent_window = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.mouse = '';


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
--lvim.builtin.notify.active = true
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


lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


-- Additional Plugins
lvim.plugins = {
    { 'catppuccin/nvim' },
    { 'Mofiqul/dracula.nvim' },
    { 'zhou-michael/cpp-javadoc' },
    { 'folke/tokyonight.nvim' },
    { 'lervag/vimtex' },
    { 'KeitaNakamura/tex-conceal.vim' },
    { 'kaicataldo/material.vim' },
    { 'shaunsingh/nord.nvim' },
    { 'tanvirtin/monokai.nvim' },
    { 'smjonas/snippet-converter.nvim' },
    { 'navarasu/onedark.nvim' },
    { 'sirver/ultisnips' },
    { 'quangnguyen30192/cmp-nvim-ultisnips' },
    { 'onsails/lspkind.nvim' },
}

-- I love Michael Zhou
require('cpp-javadoc').setup()

-- Convert Gilles Castel's and my snippets from ultisnips to luasnip
-- require("snippet-converter")
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "$HOME/.config/lvim/snippets" } })
-- lvim.builtin.luasnip.sources.friendly_snippets = false
lvim.builtin.luasnip.active = false
-- lvim.builtin.cmp.active = false

-- Vimtex for note-taking
vim.g.tex_flavor = 'latex'
vim.g.vimtex_compiler_latexmk = {
    build_dir = 'build',
}
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quick_fix_mode = 0
vim.opt.conceallevel = 1
vim.g.tex_conceal = 'abdmg'

-- Set up nvim-cmp with ultisinps
require("nvim-cmp")
