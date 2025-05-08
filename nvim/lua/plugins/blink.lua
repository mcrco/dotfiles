return {
    "saghen/blink.cmp",
    opts = {
        keymap = {
            preset = "enter",
            ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        sources = {
            compat = {},
            default = function(ctx)
                local success, node = pcall(vim.treesitter.get_node)
                if
                    success
                    and node
                    and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
                then
                    return { "buffer" }
                elseif vim.bo.filetype == "tex" then
                    return { "lsp", "path" }
                else
                    return { "lsp", "path", "snippets", "buffer" }
                end
            end,
        },

        -- snippets = {
        --     expand = function(args)
        --         vim.fn["UltiSnips#Anon"](args.body)
        --     end,
        -- },

        completion = {
            menu = { border = "rounded" },
            documentation = { window = { border = "rounded" } },
        },
    },
}
