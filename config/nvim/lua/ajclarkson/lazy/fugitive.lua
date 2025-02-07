local toggle_fugitive = function()
    local winIds = vim.api.nvim_list_wins()
    for _, id in pairs(winIds) do
        local status = pcall(vim.api.nvim_win_get_var, id, "fugitive_status")
        if status then
            vim.api.nvim_win_close(id, false)
            return
        end
    end
    vim.cmd("Git")
end

return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>gs", toggle_fugitive)
        local ajclarkson_fugitive = vim.api.nvim_create_augroup("ajclarkson_fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = ajclarkson_fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = {buffer = bufnr, remap = false}
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)

                -- rebase always
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({'pull --rebase'})
                end, opts)

                -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                -- needed if i did not set the branch up correctly
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
            end,
        })
    end
}
