return {
    -- ToggleTerm / Terminals
    {
        "akinsho/toggleterm.nvim",
        version = "*",

        config = function()
            require("toggleterm").setup({
                -- size = 20,
                open_mapping = [[<c-\>]],
                shading_factor = "5",
            })

            -- -- Counts the number of terminals that exist
            function CountTerms()
                local buffers = vim.api.nvim_list_bufs()
                local terminal_count = 0

                for _, buf in ipairs(buffers) do
                    if vim.bo[buf].buftype == "terminal" then
                        terminal_count = terminal_count + 1
                    end
                end
                return terminal_count
            end

            -- Floating terminal
            vim.keymap.set("n", "<c-]>", ":ToggleTerm direction=float<cr>", { silent = true, desc = "Float Terminal" })
            vim.keymap.set("t", "<c-]>",
                function()
                    vim.cmd("ToggleTerm")
                end,
                { noremap = true, silent = true, desc = "Close Terminal" })

            -- Horizontal terminal
            vim.keymap.set("n", "<c-\\>", ":ToggleTerm direction=horizontal<cr>",
                { noremap = true, silent = true, desc = "Horizontal Terminal" })
            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "t -> n" })

            -- Create new terminals
            vim.keymap.set("n", "<leader>tn", function()
                local command = CountTerms() + 1 .. "ToggleTerm"
                vim.cmd(command)
            end, { noremap = true, silent = true, desc = "New" })

            -- Close current terminal
            vim.keymap.set("n", "<leader>te", function()
                if CountTerms() == 0 then
                    return ""
                end
                vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
            end, { noremap = true, silent = true, desc = "Exits" })
        end,
    },
}
