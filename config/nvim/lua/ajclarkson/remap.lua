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

-- Disable arrow keys to force using vim navigations
vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("i", "<Up>", "<nop>")
vim.keymap.set("v", "<Up>", "<nop>")

vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("i", "<Down>", "<nop>")
vim.keymap.set("v", "<Down>", "<nop>")

vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("i", "<Left>", "<nop>")
vim.keymap.set("v", "<Left>", "<nop>")

vim.keymap.set("n", "<Right>", "<nop>")
vim.keymap.set("i", "<Right>", "<nop>")
vim.keymap.set("v", "<Right>", "<nop>")

-- Map :update to leader w for faster saves
vim.keymap.set("n", "<leader>w", ":update<CR>")
