-- <https://github.com/brenton-leighton/multiple-cursors.nvim>
return {
	"brenton-leighton/multiple-cursors.nvim",
	version = "*",
	opts = {
		enable_split_paste = true,
		custom_key_maps = {
			{
				{ "n", "v" },
				"gl",
				function(_, count)
					if count == 0 then
						vim.cmd("normal! $")
					else
						vim.cmd("normal! " .. count .. "$")
					end
				end,
			},
    		{
    			{ "n", "v" },
    			"gh",
    			function(_, count)
    				if count == 0 then
    					vim.cmd("normal! ^")
					else
						vim.cmd("normal! " .. count .. "^")
					end
				end,
			},
	        {
    			{ "n" },
    			"gcc",
    			function(_, count)
    				if count == 0 then
    					vim.cmd("normal! gcc")
					else
						vim.cmd("normal! " .. count .. "gcc")
					end
				end,
			},
            {
    			{ "v" },
    			"gc",
    			function(_, count)
    				if count == 0 then
    					vim.cmd("normal! gc")
					else
						vim.cmd("normal! " .. count .. "gc")
					end
				end,
			},

		},
	},
	keys = {
		{ "<C-j>", "<cmd>MultipleCursorsAddDown<cr>", mode = { "n", "v" } },
		{ "<C-k>", "<cmd>MultipleCursorsAddUp<cr>", mode = { "n", "v" } },
		{ "<C-LeftMouse>", "<cmd>MultipleCursorsMouseAddDelete<cr>", mode = { "n", "v" } },
	},
}
