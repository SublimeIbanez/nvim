return {
	{
		"nvimtools/none-ls.nvim",

		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.asmfmt,
					--null_ls.builtins.formatting.astgrep,
					--null_ls.builtins.formatting.ts_standard,
					null_ls.builtins.formatting.sqlfmt,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.csharpier,
					null_ls.builtins.formatting.prettier,
					--null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.completion.spell,
				},
			})

			vim.keymap.set("n", "<space>fmt", vim.lsp.buf.format, {})
		end,
	},
}
