return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        vim.opt.list = true
        vim.opt.listchars:append "eol:↴"
        require('ibl').setup({})
    end
} 
