return {
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
