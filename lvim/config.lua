-- general
lvim.log.level = "warn"
lvim.format_on_save = {
    pattern = "*.java", "*.lua", "*.python", "*.js"
}

lvim.colorscheme = "tokyonight"
vim.opt.termguicolors = true
vim.g.material_terminal_italics = 1
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
lvim.transparent_window = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

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
    {"zhou-michael/cpp-javadoc"},
    {"lervag/vimtex"},
    {'kaicataldo/material.vim'},
    {'shaunsingh/nord.nvim'},
    {'tanvirtin/monokai.nvim'},
    {'sirver/ultisnips'},
}

-- I love Michael Zhou
require('cpp-javadoc').setup()

-- Latex Notes
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quick_fix_mode = 0
vim.opt.conceallevel = 1
vim.g.tex_conceal = 'abdmg'

vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
