-- Something necessary
vim.cmd[[syntax enable]]

-- Zathura as pdf viewer
vim.g.vimtex_view_method = 'zathura'

-- Tex Stuff
vim.g.tex_flavor = 'latex'
vim.g.vimtex_compiler_latexmk = {
    build_dir = "build"
}
vim.g.tex_conceal = 'abdmgs'

