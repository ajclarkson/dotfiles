local augroup = vim.api.nvim_create_augroup
local ajclarksonGroup = augroup('ajclarksonGroup', {})

local autocmd = vim.api.nvim_create_autocmd

-- Turn no neck pain plugin on automatically for markdown files
autocmd('FileType', {
    group = ajclarksonGroup,
    pattern = { "markdown", "*.md" },
    callback = function ()
        require('no-neck-pain').enable()
    end
})
