local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    return
end

local lspkind_setup, lspkind = pcall(require, "lspkind")
if not lspkind_setup then
    return
end

vim.opt.completeopt = "menu,menuone,noselect"
vim.cmd("highlight Pmenu guibg=NONE")

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'ultisnips' }, -- For ultisnips users.
            { name = 'buffer' },
            { name = 'path' },
    }),
    formatting = {
        format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = "...",
    }),
  },
})
