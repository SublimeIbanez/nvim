-- Leaders
vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set("n", "<M-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<M-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<M-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<M-l>", ":wincmd l<CR>")

-- Remove the search highlight
vim.keymap.set("n", "<leader>rh", ":nohlsearch<CR>")

-- Open netw
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")

-- Quick navigation of a line
vim.keymap.set({ "n", "v" }, "gl", "$")
vim.keymap.set({ "n", "v" }, "gh", "^")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<c-F>", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
