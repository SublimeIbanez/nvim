return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },

        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fht", builtin.help_tags, {})
            vim.keymap.set("n", "<leader>fhf", builtin.help_tags, {})
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",

        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dopdown
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        depend   = "nvim-tree/nvim-web-devicons",

        config = function()
            require("bufferline").setup{}
        end,
        vim.keymap.set("n", "<A-.>", ":BufferLineCycleNext<CR>"),
        vim.keymap.set("n", "<A-,>", ":BufferLineCyclePrev<CR>"),
    },
}
