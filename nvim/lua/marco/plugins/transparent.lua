local setup, transparent = pcall(require, "transparent")
if not setup then
    return
end

vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
vim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]
vim.g.tokyonight_transparent = true

transparent.setup({
    enable = true,
    extra_groups = {
        "NvimTreeStatusLine"
    }
})
