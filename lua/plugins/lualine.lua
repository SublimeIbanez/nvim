return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },

    config = function()
        require("lualine").setup({
            options = {
                disabled_filetypes = {     -- Filetypes to disable lualine for.
                    "packer",
                    "neo-tree",
                    statusline = {},       -- only ignores the ft for statusline.
                    winbar = {},           -- only ignores the ft for winbar.
                },
                ignore_focus = {
                    "packer",
                    "NVimTree"
                },
                theme = "codedark",--wal --theme ashes"
            }
        })
    end,
}
