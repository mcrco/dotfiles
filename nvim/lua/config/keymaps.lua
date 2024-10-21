-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

vim.keymap.del("n", "<leader>bb")
map("n", "<leader>bb", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>c", LazyVim.ui.bufremove, { desc = "Delete Buffer" })

local Util = require("lazyvim.util")
vim.keymap.set("n", "<C-/>", function()
    Util.terminal(nil, { border = "rounded" })
end, { desc = "Term with border" })
