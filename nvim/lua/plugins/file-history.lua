return {
    "dawsers/file-history.nvim",
    config = function()
        local file_history = require("file_history")
        file_history.setup({
            backup_dir = "~/.file-history-git",
            git_cmd = "git",
            hostname = nil,
        })

        local function export_file_history()
            local current_fp = vim.fn.expand("%:p")
            if current_fp == "" then
                vim.notify("No file is currently open.", vim.log.levels.WARN)
                return
            end

            local output_file = vim.fn.fnamemodify(current_fp, ":h")
                .. "/"
                .. vim.fn.fnamemodify(current_fp, ":t:r")
                .. "-history.txt"
            local backup_dir = vim.fn.expand("$HOME") .. "/.file-history-git"

            -- Construct the Git command
            local cmd = string.format(
                "git --git-dir=%s --work-tree=%s log --follow -p -- %s > %s",
                backup_dir .. "/.git",
                backup_dir,
                backup_dir .. "/" .. vim.fn.hostname() .. current_fp,
                output_file
            )

            vim.notify(cmd)

            -- Execute the command and capture its result
            local result = os.execute(cmd)

            if result == 0 then
                vim.notify("File history exported to " .. output_file, vim.log.levels.INFO)
            else
                vim.notify("Failed to export file history. Check logs for details.", vim.log.levels.ERROR)
                print("Command failed with result: " .. tostring(result))
            end
        end

        -- Create a Neovim command for exporting file history
        vim.api.nvim_create_user_command("ExportFileHistory", export_file_history, {})
    end,
}
