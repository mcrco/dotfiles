return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "quangnguyen30192/cmp-nvim-ultisnips",
        "hrsh7th/cmp-omni",
    },
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
        -- opts parameter is the default options table
        -- the function is lazy loaded so cmp is able to be required
        local cmp = require("cmp")

        -- modify the sources part of the options table
        opts.sources = cmp.config.sources({
            { name = "nvim_lsp", priority = 1000 },
            { name = "luasnip", priority = 750 },
            { name = "buffer", priority = 500 },
            { name = "path", priority = 250 },
            { name = "ultisnips", priority = 700 }, -- add new source
            { name = "omni", priority = 700 }, -- add new source
        })

        -- use ultisnips
        opts.snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body)
            end,
        }

        local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

        opts.mapping = vim.tbl_extend("force", opts.mapping, {
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif vim.snippet.active({ direction = 1 }) then
                    vim.schedule(function()
                        vim.snippet.jump(1)
                    end)
                else
                    cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif vim.snippet.active({ direction = -1 }) then
                    vim.schedule(function()
                        vim.snippet.jump(-1)
                    end)
                else
                    cmp_ultisnips_mappings.jump_backwards(fallback)
                end
            end, { "i", "s" }),
        })

        vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
        vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

        opts.window = {
            completion = cmp.config.window.bordered({
                border = "rounded", -- You can use 'single', 'double', 'rounded', 'solid', etc.
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                scrollbar = true, -- Optional: enable scrollbar
            }),
            documentation = cmp.config.window.bordered({
                border = "rounded",
                winhighlight = "NormalFloat:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
            }),
        }

        -- No buffer text for latex + text wrap
        cmp.setup.filetype("tex", {
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "path", priority = 250 },
                -- { name = "ultisnips", priority = 700 },
                { name = "omni", priority = 700 },
            }),
        })
    end,
}
