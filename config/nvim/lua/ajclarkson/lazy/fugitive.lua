return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>gs", "<cmd>:0G<CR>")
    end
}
