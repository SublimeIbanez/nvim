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
            vim.keymap.set("v", "gg", function()
                vim.cmd("GitLink true")
            end)

            vim.keymap.set("n", "<Leader>gg", function()
                vim.cmd("GitLink")
            end)
        end,
    },
}
