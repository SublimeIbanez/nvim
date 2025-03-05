-- <https://github.com/brenton-leighton/multiple-cursors.nvim>
return {
  -- Multi Cursors / Multiple Cursors
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",
    dependencies = {
      "echasnovski/mini.nvim",
    },

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
          { "n", "v" },
          "<leader>cch",
          function(_, count)
            if count == 0 then
              vim.cmd("normal! <leader>cch")
            else
              vim.cmd("normal! " .. count .. "<leader>cch")
            end
          end,
        },
      },
      pre_hook = function()
        vim.g.minipairs_disable = true
      end,
      post_hook = function()
        vim.g.minipairs_disable = false
      end,
    },
    keys = {
      { "<C-j>",         "<cmd>MultipleCursorsAddDown<cr>",        mode = { "n", "v" } },
      { "<C-k>",         "<cmd>MultipleCursorsAddUp<cr>",          mode = { "n", "v" } },
      { "<C-LeftMouse>", "<cmd>MultipleCursorsMouseAddDelete<cr>", mode = { "n", "v" } },
    },

  },
}
