local mason_setup, mason = pcall(require, "mason")
if not mason_setup then
	return
end

local mason_lspconfig_setup, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_setup then
	return
end

local mason_null_ls_setup, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_setup then
	return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lspconfig.setup({
	ensure_installed = {
		"sumneko_lua",
		"clangd",
		"jdtls",
	},
	automatic_installation = true,
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
