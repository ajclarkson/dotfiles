return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup()

        wk.add({
            { "<leader>g", group = "git" },
            { "<leader>p", group = "files" },
        })
    end
}
