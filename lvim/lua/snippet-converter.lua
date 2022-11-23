local snip_conv_status, snip_conv = pcall(require, "snippet_converter")
if not snip_conv_status then
    return
end

local template = {
    -- name = "t1", (optionally give your template a name to refer to it in the `ConvertSnippets` command)
    sources = {
        ultisnips = {
            -- Add snippets from (plugin) folders or individual files on your runtimepath...
            "./vim-snippets/UltiSnips",
            "./latex-snippets/tex.snippets",
            -- ...or use absolute paths on your system.
            vim.fn.stdpath("config") .. "/UltiSnips",
        },
    },
    output = {
        -- Specify the output formats and paths
        vscode_luasnip = {
            vim.fn.stdpath("config") .. "/luasnip_snippets",
        },
    },
}

snip_conv.setup {
  templates = { template },
}

