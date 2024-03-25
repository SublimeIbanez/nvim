return {
    {
        "Cassin01/wf.nvim",

        config = function()
            require("wf").setup({
                theme = "space", -- default, space, chad
            })
            local which_key = require("wf.builtin.which_key")
            local register = require("wf.builtin.register")
            local bookmark = require("wf.builtin.bookmark")
            local buffer = require("wf.builtin.buffer")
            local mark = require("wf.builtin.mark")

            -- Register
            vim.keymap.set("n", "<leader>wr", register(), {
                noremap = true, silent = true, desc = "[wf.nvim] Register"
            })

            -- Bookmark
            vim.keymap.set(
                "n",
                "<Space>wbo",
                -- bookmark(bookmark_dirs: table, opts?: table) -> function
                -- bookmark_dirs: directory or file paths
                -- opts?: option
                bookmark({
                    nvim = "~/.config/nvim",
                    zsh = "~/.zshrc",
                }),
                { noremap = true, silent = true, desc = "[wf.nvim] bookmark" }
            )

            -- Buffer
            -- Buffer
            vim.keymap.set(
                "n",
                "<Space>wbu",
                -- buffer(opts?: table) -> function
                -- opts?: option
                buffer(),
                { noremap = true, silent = true, desc = "[wf.nvim] buffer"}
            )

            -- Mark
            vim.keymap.set(
                "n",
                "'",
                -- mark(opts?: table) -> function
                -- opts?: option
                mark(),
                { nowait = true, noremap = true, silent = true, desc = "[wf.nvim] mark"}
            )

            -- Which Key
            vim.keymap.set(
                "n",
                "<Leader>",
                -- mark(opts?: table) -> function
                -- opts?: option
                which_key({ text_insert_in_advance = "<Leader>" }),
                { noremap = true, silent = true, desc = "[wf.nvim] which-key /", }
            )
        end
    }
}
