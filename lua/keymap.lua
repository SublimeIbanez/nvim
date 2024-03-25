-- Leaders
vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set("n", "<M-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<M-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<M-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<M-l>", ":wincmd l<CR>")

-- Remove the search highlight
vim.keymap.set("n", "<leader>hr", ":nohlsearch<CR>", { desc = "Highlight Remove" })

-- Open netw
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "Open NetW"})

-- Quick navigation of a line
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "Goto end of Line"})
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "Goto end of Line"})



-- Telescope

