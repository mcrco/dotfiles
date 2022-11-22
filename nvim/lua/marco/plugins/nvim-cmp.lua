local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    return
end


-- local snip_status, snip = pcall(require, "ultisnips")

vim.opt.completeopt = "menu,menuone,noselect"
vim.cmd("highlight Pmenu guibg=NONE")

-- cmp_ultisnips.setup{}
-- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- ["<Tab>"] = cmp.mapping(
        --     function(fallback)
        --         cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        --     end,
        --     { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        -- ),
        -- ["<S-Tab>"] = cmp.mapping(
        --     function(fallback)
        --         cmp_ultisnips_mappings.jump_backwards(fallback)
        --     end,
        --     { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        -- ),
    }),
    sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'ultisnips' }, -- For ultisnips users.
            { name = 'buffer' },
            { name = 'path' },
    }),
})
