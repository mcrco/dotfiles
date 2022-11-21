local setup, comment = pcall(require, "Comment")
if not setup then
    return
end
comment.setup({
    toggler = {
        line = '<leader>c',
    },
    opleader = {
        -- Line-comment keymap
        line = 'gc',
    },
})
