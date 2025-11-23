return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            require("lspconfig.configs").ty = {
                default_config = {
                    cmd = { "ty", "server" },
                    filetypes = { "python" },
                    root_dir = require("lspconfig.util").root_pattern("pyproject.toml", ".git"),
                    single_file_support = true,
                    settings = {},
                },
            }
            opts.servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            format = {
                                enable = true,
                                defaultConfig = {
                                    indent_style = "space",
                                    indent_size = "4",
                                },
                            },
                        },
                    },
                },
                ty = {},
            }
        end,
    },
}
