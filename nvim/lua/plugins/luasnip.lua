return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            { "rafamadriz/friendly-snippets", enabled = false },
        },
        config = function()
            local ls = require("luasnip")
            ls.config.setup({ enable_autosnippets = true }) -- Critical for auto-expansion
            require("luasnip.loaders.from_lua").lazy_load({
                paths = { "~/.config/nvim/lua/snippets" },
            })
        end,
    },
}
