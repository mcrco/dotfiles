return {
    "lervag/vimtex",
    init = function()
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_compiler_latexmk = {
            out_dir = "build",
        }
        vim.g.vimtex_view_method = "zathura"
        vim.opt.conceallevel = 0
        vim.o.tw = 80
        vim.g.tex_conceal = "abdmg"
    end,
    event = "BufRead",
}
