local setup, comment = pcall(require, "Comment")
print('hello')
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
