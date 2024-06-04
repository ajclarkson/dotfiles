return {
    'ThePrimeagen/harpoon',
    config = function() 
        local harpoon = require('harpoon')
        local ui = require('harpoon.ui')
        local mark = require('harpoon.mark')
        harpoon.setup()
        vim.keymap.set("n", "<C-e>", function() ui.toggle_quick_menu() end)
        vim.keymap.set("n", "<leader>a", function() mark.add_file() end)
    end
}
