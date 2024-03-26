return {
    {
        "Cassin01/wf.nvim",

        config = function()
            require("wf").setup({
                theme = "chad", -- default, space, chad
            })
            local which_key = require("wf.builtin.which_key")
            local register = require("wf.builtin.register")
            local bookmark = require("wf.builtin.bookmark")
            local buffer = require("wf.builtin.buffer")
            local mark = require("wf.builtin.mark")

            -- Register
            vim.keymap.set("n", "<leader>wr", register(), {
                noremap = true,
                silent = true,
                desc = "Register",
            })

            -- Bookmark
            vim.keymap.set(
                "n",
                "<leader>wbo",
                -- bookmark(bookmark_dirs: table, opts?: table) -> function
                -- bookmark_dirs: directory or file paths
                -- opts?: option
                bookmark({
                    nvim = "~/.config/nvim",
                    zsh = "~/.zshrc",
                }),
                { noremap = true, silent = true, desc = "WF Bookmark" }
            )

            -- Buffer
            -- Buffer
            vim.keymap.set(
                "n",
                "<leader>wbu",
                -- buffer(opts?: table) -> function
                -- opts?: option
                buffer(),
                { noremap = true, silent = true, desc = "WF Buffer" }
            )

            -- Mark
            vim.keymap.set(
                "n",
                "'",
                -- mark(opts?: table) -> function
                -- opts?: option
                mark(),
                { nowait = true, noremap = true, silent = true, desc = "Mark" }
            )

            -- Which Key
            vim.keymap.set(
                "n",
                "<leader>",
                -- mark(opts?: table) -> function
                -- opts?: option
                which_key({ text_insert_in_advance = "<leader>" }),
                { nowait = true, noremap = true, silent = true, desc = "Which-key /" }
            )

            -- vim.keymap.set(
            --  "n",
            --  "g",
            --  -- mark(opts?: table) -> function
            --  -- opts?: option
            --  which_key({ text_insert_in_advance = "g" }),
            --  { noremap = true, silent = true, desc = "Goto" }
            -- )
            -- Change the timeout to make wf snappier
            vim.o.timeout = true
            vim.o.timeoutlen = 150
        end,
        lazy = false,
    },
}
