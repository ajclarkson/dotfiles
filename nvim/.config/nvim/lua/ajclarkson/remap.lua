-- Set a better leader key
vim.g.mapleader = " "

-- A different way to get into the default file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move the highlighted lines up and down in the file
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank files into the system clipboard register rather than vim
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>Y", "\"+Y")

-- Keep the cursor in the middle when half page jumping or searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over the top of a buffer without taking the contents to the register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Navigate the buffers in a more natural way
vim.keymap.set("n", "<leader>j", ":bp<CR>")
vim.keymap.set("n", "<leader>k", ":bn<CR>")

-- Escape insert mode by rolling jk 
vim.keymap.set("i", "jk", "<esc>")

-- Map :update to leader w for faster saves
vim.keymap.set("n", "<leader>w", ":update<CR>")

-- Easier start / end line navigations from the home row
vim.keymap.set("", "H", "_")
vim.keymap.set("", "L", "g_")

-- Easier split navigation
vim.keymap.set("", "<C-h>", "<C-w><left>")
vim.keymap.set("", "<C-j>", "<C-w><down>")
vim.keymap.set("", "<C-k>", "<C-w><up>")
vim.keymap.set("", "<C-l>", "<C-w><right>")
