return {
    {
        "tpope/vim-fugitive",
    },
    {
        "lewis6991/gitsigns.nvim",

        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "lsproule/git_lines",

        config = function()
            vim.keymap.set("v", "gp", function()
                vim.cmd("GitLink true")
            end)

            vim.keymap.set("n", "<Leader>gp", function()
                vim.cmd("GitLink")
            end)
        end,
    },
}
