require('obsidian').setup({

    workspaces = {
        {
            name = "Second Brain",
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Second Brain"
        }
    },
    completion = {
        nvim_cmp = true,
        min_chars = 2,

    },
    notes_subdir = "0 Inbox",
    new_notes_location = "notes_subdir",
    note_id_func = function(title)
        return title
    end,
    note_frontmatter_func = function(note)
        return {}
    end,
    templates = {
        subdir = "003 Templates",
        date_format = "%Y%m%d",
        time_format = "%H%M",
    }
})

vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
