-- Leaders
vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set("n", "<M-k>", ":wincmd k<CR>", { noremap = true, silent = true, desc = "Move up" })
vim.keymap.set("n", "<M-j>", ":wincmd j<CR>", { noremap = true, silent = true, desc = "Move down" })
vim.keymap.set("n", "<M-h>", ":wincmd h<CR>", { noremap = true, silent = true, desc = "Move left" })
vim.keymap.set("n", "<M-l>", ":wincmd l<CR>", { noremap = true, silent = true, desc = "Move right" })

-- Remove the search highlight
vim.keymap.set("n", "<leader>hr", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Highlight Remove" })

-- Open netw
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { noremap = true, silent = true, desc = "Open NetW" })

-- Quick navigation of a line
vim.keymap.set({ "n", "v" }, "gl", "$", { noremap = true, silent = true, desc = "Goto end of Line" })
vim.keymap.set({ "n", "v" }, "gh", "^", { noremap = true, silent = true, desc = "Goto end of Line" })
