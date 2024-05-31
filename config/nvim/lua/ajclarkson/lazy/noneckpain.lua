return  {
    "shortcuts/no-neck-pain.nvim", 
    version = "*",
    config = function()
        require('no-neck-pain').setup({
            mappings = {
                toggle = "<Leader>nn",
                enabled = true
            }
        })

    end
}
