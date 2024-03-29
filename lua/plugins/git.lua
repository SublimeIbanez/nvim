return {
    -- Fugitive
    {
        "tpope/vim-fugitive",
    },

    -- Git Signs
    {
        "lewis6991/gitsigns.nvim",

        config = function()
            require("gitsigns").setup()
        end,
    },

    -- Git Links
    {
        "lsproule/git_lines",

        config = function()
            vim.keymap.set("v", "<leader>pg", function()
                vim.cmd("GitLink true")
            end)

            vim.keymap.set("n", "<Leader>pg", function()
                vim.cmd("GitLink")
            end)
        end,
    },
}
