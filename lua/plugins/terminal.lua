return {
	{
    	"numToStr/FTerm.nvim",

		config = function()
            require("FTerm").setup({

				border = "double",
				dimensions = {
					height = 0.7,
					width = 0.7,
				},
			})

            -- Set up BTOP
            local fterm = require("FTerm")
            local btop = fterm:new({
                ft = "fterm_btop",
                cmd = "btop",
            })

            local gitui = fterm:new({
                ft = "fterm_gitui",
                cmd = "gitui",
                dimensions = {
                    height = 0.7,
                    width = 0.7,
                }
            })

            vim.keymap.set("n", "<C-t>", '<CMD>lua require("FTerm").toggle()<CR>', { desc = "Open Terminal" })
            vim.keymap.set("t", "<C-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { desc = "Hide Terminal" })
            vim.keymap.set("t", "<C-b>", function()
                btop:toggle()
            end, { desc = "Toggle BTOP <In FTerm>" })
            vim.keymap.set("t", "<C-g>", function()
                gitui:toggle()
            end, { desc = "Toggle GitUI <In FTerm>" })
		end,
	},
}
