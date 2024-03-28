return {
    {
        -- Adds `s` to surround the current actions
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",

        config = function()
            require("nvim-surround").setup({})
            vim.keymap.set({ "n" }, "<leader>?s", "<cmd>:h nvim-surround.usage<cr>",
                { noremap = true, silent = true, desc = "Surround" })
        end,
    },
}
