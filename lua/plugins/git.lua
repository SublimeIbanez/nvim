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
            local git = require("git_lines")

            git.setup({
                keymaps = {
                    { "n", "<leader>pg", vim.cmd.GitLink,
                        { noremap = true, silent = true, desc = "GitLink" } },
                    {
                        "v", "<leader>pg",
                        function()
                            vim.cmd("GitLink true")
                        end,
                        { noremap = true, silent = true, desc = "GitLink" },
                    },
                }
            })
        end,
    },
}
