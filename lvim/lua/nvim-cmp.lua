local cmp = lvim.builtin.cmp
local lspkind = require'lspkind'

cmp.snippet = {
    expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
    end
}

cmp.sources = require'cmp'.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' }, -- For ultisnips users.
    { name = 'buffer' },
    { name = 'path' },
})
cmp.formatting = {
    format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = "...",
    })
}


vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
