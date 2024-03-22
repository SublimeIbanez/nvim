return {
	{
		"numToStr/FTerm.nvim",

		config = function()
            require("FTerm").setup({

				border = "double",
				dimensions = {
					height = 0.9,
					width = 0.9,
				},
			})

            vim.keymap.set("n", "<C-Q>", '<CMD>lua require("FTerm").toggle()<CR>')
            vim.keymap.set("t", "<C-Q>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
		end,
	},
}
