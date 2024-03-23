return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- only load treesitter for a existing buffer or a new buffer.
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
}

