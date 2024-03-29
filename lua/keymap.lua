-- Leaders
vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set("n", "<M-k>", ":wincmd k<CR>", { noremap = true, silent = true, desc = "Buffer Move Up" })
vim.keymap.set("n", "<M-j>", ":wincmd j<CR>", { noremap = true, silent = true, desc = "Buffer Move Down" })
vim.keymap.set("n", "<M-h>", ":wincmd h<CR>", { noremap = true, silent = true, desc = "Buffer Move left" })
vim.keymap.set("n", "<M-l>", ":wincmd l<CR>", { noremap = true, silent = true, desc = "Buffer Move right" })

-- Remove the search highlight
vim.keymap.set("n", "<leader>hr", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Remove" })

-- Open netw
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { noremap = true, silent = true, desc = "NetW" })

-- Quick navigation of a line
vim.keymap.set({ "n", "v" }, "gl", "$", { noremap = true, silent = true, desc = "Goto end of Line" })
vim.keymap.set({ "n", "v" }, "gh", "^", { noremap = true, silent = true, desc = "Goto end of Line" })

-- 
vim.keymap.set({ "n", "v" }, "<leader>yc", [["+y]], { noremap = true, silent = true, desc = "Clipboard" })

-- Help
vim.keymap.set({ "n", "v" }, "<leader>?s", "<cmd>:h nvim-surround.usage<cr>",
    { noremap = true, silent = true, desc = "Surround" })
vim.keymap.set({ "n", "v" }, "<leader>?n", "<cmd>:h neo-tree<cr>",
    { noremap = true, silent = true, desc = "Neotree" })
vim.keymap.set({ "n", "v" }, "<leader>?t", "<cmd>:h telescope.nvim<cr>",
    { noremap = true, silent = true, desc = "Telescope" })
vim.keymap.set({ "n", "v" }, "<leader>?m", "<cmd>:h multiple-cursors.nvim-overview<cr>",
    { noremap = true, silent = true, desc = "MultipleCursors" })
vim.keymap.set({ "n", "v" }, "<leader>?b", "<cmd>:h bufferline<cr>",
    { noremap = true, silent = true, desc = "Bufferline" })
vim.keymap.set({ "n", "v" }, "<leader>?d", "<cmd>:h dap.txt<cr>",
    { noremap = true, silent = true, desc = "Debug" })
vim.keymap.set({ "n", "v" }, "<leader>?g", "<cmd>:h fugitive<cr>",
    { noremap = true, silent = true, desc = "Git" })
vim.keymap.set({ "n", "v" }, "<leader>?T", "<cmd>:h toggleterm.txt<cr>",
    { noremap = true, silent = true, desc = "Terminal" })
vim.keymap.set({ "n", "v" }, "<leader>?k", "<cmd>:h map<cr>",
    { noremap = true, silent = true, desc = "Keybinds" })
vim.keymap.set({ "n", "v" }, "<leader>?w", "<cmd>:h which-key.nvim.txt<cr>",
    { noremap = true, silent = true, desc = "Which-Key" })
vim.keymap.set({ "n", "v" }, "<leader>?D", "<cmd>:h dashboard.txt<cr>",
    { noremap = true, silent = true, desc = "Dashboard" })

-- Whitespace
vim.keymap.set({ "n", "v" }, "<leader>cw",
    function()
        vim.wo.list = not vim.wo.list
    end,
    { noremap = true, silent = true, desc = "Toggle Whitespace" })

-- Relative Numbers
vim.keymap.set({ "n", "v" }, "<leader>cr",
    function()
        vim.wo.relativenumber = not vim.wo.relativenumber
    end,
    { noremap = true, silent = true, desc = "Toggle Relative Number" })
