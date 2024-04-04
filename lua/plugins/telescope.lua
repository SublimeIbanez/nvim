return {
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files,
                { noremap = true, silent = true, desc = "Find File" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep,
                { noremap = true, silent = true, desc = "Find Grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers,
                { noremap = true, silent = true, desc = "Find Buffer" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags,
                { noremap = true, silent = true, desc = "Find Help Tags" })
            vim.keymap.set("n", "<leader>co", builtin.diagnostics,
                { noremap = true, silent = true, desc = "Diagnostics List" })
        end,
    },

    -- Telescope UI
    {
        "nvim-telescope/telescope-ui-select.nvim",

        config = function()
            require("telescope").setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        -- "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        -- "--trim"     -- add this value
                    },
                    layout_config = {
                        vertical = { width = 0.7 }
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dopdown,
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
