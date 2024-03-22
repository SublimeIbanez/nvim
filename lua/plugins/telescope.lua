return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },

        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<space>ff", builtin.find_files, {})
            vim.keymap.set("n", "<space>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<space>fb", builtin.buffers, {})
            vim.keymap.set("n", "<space>fh", builtin.help_tags, {})
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
}
