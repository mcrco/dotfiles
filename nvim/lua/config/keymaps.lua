local map = vim.keymap.set

map("n", "<leader>bb", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>c", function()
    Snacks.bufdelete()
end, { desc = "Delete Buffer" })

vim.keymap.set("n", "<C-/>", function()
    Snacks.terminal(nil, { border = "rounded" })
end, { desc = "Term with border" })
