-- <https://github.com/brenton-leighton/multiple-cursors.nvim> 
return {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",
    opts = {
        enable_split_paste = true,
        custom_key_maps = {
            {{ "n", "v" }, "gl", function(_, count)
                if count == 0 then
                    vim.cmd("normal! $")
                else
                    vim.cmd("normal! " .. count .. "$")
                end
            end
            },
            {{ "n", "v" }, "gh", function(_, count)
                if count == 0 then
                    vim.cmd("normal! ^")
                else
                    vim.cmd("normal! " .. count .. "^")
                end
            end
            },
        }
    },
    keys = {
        {"<M-j>", "<cmd>MultipleCursorsAddDown<cr>", mode = { "n", "v" }},
        {"<M-k>", "<cmd>MultipleCursorsAddUp<cr>", mode = { "n", "v" }},
        {"<M-LeftMouse>", "<cmd>MultipleCursorsMouseAddDelete<cr>", mode = { "n", "v" }},
    },
}

