return {
    {
        "numToStr/Comment.nvim",
        lazy = false,

        config = function()
            require("Comment").setup({
                config = {
                    ---Add a space b/w comment and the line
                    padding = true,
                    ---Whether the cursor should stay at its position
                    sticky = true,
                    ---Lines to be ignored while (un)comment
                    ignore = nil,
                    ---LHS of toggle mappings in NORMAL mode
                    toggler = {
                        ---Line-comment toggle keymap
                        line = "gc",
                        ---Block-comment toggle keymap
                        block = "gbc", --"<leader>gcb",
                    },
                    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
                    opleader = {
                        ---Line-comment keymap
                        line = "<leader>gcl",
                        ---Block-comment keymap
                        block = "<leader>gcb",
                    },
                    ---LHS of extra mappings
                    extra = {
                        ---Add comment on the line above
                        above = "<leader>cck",
                        ---Add comment on the line below
                        below = "<leader>ccj",
                        ---Add comment at the end of line
                        eol = "<leader>ccl",
                    },
                    ---Enable keybindings
                    ---NOTE: If given `false` then the plugin won't create any mappings
                    mappings = {
                        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                        basic = false,
                        ---Extra mapping; `gco`, `gcO`, `gcA`
                        extra = false,
                    },
                    ---Function to call before (un)comment
                    pre_hook = nil,
                    ---Function to call after (un)comment
                    post_hook = nil,
                },
            })
        end,
    },
}
