local cmp = lvim.builtin.cmp
local lspkind = require 'lspkind'

-- Use ultisnips
cmp.snippet = {
    expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
    end
}

-- Modify sources for cmp
local new_sources = cmp.sources
lvim.builtin.luasnip.sources.friendly_snippets = false
lvim.builtin.luasnip.active = false
-- Add ultisnips
table.insert(new_sources, { name = "ultisnips" })
table.insert(new_sources, { name = "omni" })
-- Update sources
cmp.sources = new_sources

-- No buffer text for latex + text wrap
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'tex',
    callback = function(t)
        -- text wrapping
        vim.opt.wrap = true

        -- remove buffer as cmp source
        local sources_to_delete = {
            "buffer",
            "luasnip"
        }
        new_sources = vim.tbl_filter(function(source)
            return not vim.tbl_contains(sources_to_delete, source.name)
        end, new_sources)
        cmp.sources = new_sources
        require('cmp').setup(cmp)
    end
})

-- Preferred formatting for popup window
cmp.formatting = {
    format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = "...",
    })
}

vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
