return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },

        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "c",
                    "cpp",
                    "c_sharp",
                    "lua",
                    "vim",
                    "vimdoc",
                    "elixir",
                    "rust",
                    "javascript",
                    "typescript",
                    "html",
                    "css",
                    "go"
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     opts = {},
    --     config = function()
    --         local inlay_highlight = { "inlay", }
    --         local scope_highlight = { "scope", }
    --
    --         local hooks = require "ibl.hooks"
    --         hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    --             vim.api.nvim_set_hl(0, "inlay", { fg = "#7f623d"})
    --             vim.api.nvim_set_hl(0, "scope", { fg = "#777777"})
    --         end)
    --         require("ibl").setup({
    --             indent = {
    --                 highlight = inlay_highlight
    --             },
    --             scope = {
    --                 highlight = scope_highlight
    --             }
    --         })
    --     end,
    -- },
}

