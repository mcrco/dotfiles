local setup, lspconfig = pcall(require, "lspconfig")
if not setup then
    return
end

lspconfig.pyright.setup{}
lspconfig.sumneko_lua.setup{}

