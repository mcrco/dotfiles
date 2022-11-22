local lualine_setup, lualine = pcall(require, "lualine")
if not lualine_setup then
	return
end

local lualine_tokyonight = require("lualine.themes.tokyonight")
lualine.setup({
	options = {
		theme = lualine_tokyonight,
	},
})
