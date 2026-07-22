return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "bash",
                "java",
                "css",
                "fish",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "typescript",
                "tsx",
                "yaml",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
