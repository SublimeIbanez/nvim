-- Leaders
vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set("n", "<M-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<M-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<M-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<M-l>", ":wincmd l<CR>")

-- Remove the search highlight
vim.keymap.set("n", "<leader>rh", ":nohlsearch<CR>")

-- Open netw
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")

-- Quick navigation of a line
vim.keymap.set({ "n", "v" }, "gl", "$")
vim.keymap.set({ "n", "v" }, "gh", "^")
