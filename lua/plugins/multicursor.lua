-- <https://github.com/brenton-leighton/multiple-cursors.nvim>
return {
  -- Multi Cursors / Multiple Cursors
  {
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
        { { "n", "i" }, "<Leader>gcc", function() vim.cmd("normal gcc") end },
        { { "v" },      "<Leader>gc",  function() vim.cmd("normal gc") end },
      },
    },
    keys = {
      {
        "<C-j>",
        "<Cmd>MultipleCursorsAddDown<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and move down"
      },
      {
        "<C-k>",
        "<Cmd>MultipleCursorsAddUp<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and move up"
      },
      {
        "<C-Up>",
        "<Cmd>MultipleCursorsAddUp<CR>",
        mode = { "n", "x", "i" },
        desc = "Add cursor and move up"
      },
      {
        "<C-Down>",
        "<Cmd>MultipleCursorsAddDown<CR>",
        mode = { "n", "x", "i" },
        desc = "Add cursor and move down"
      },
      {
        "<C-LeftMouse>",
        "<Cmd>MultipleCursorsMouseAddDelete<CR>",
        mode = { "n", "v" },
        desc = "Add or remove cursor"
      },
      {
        "<Leader>mv",
        "<Cmd>MultipleCursorsAddVisualArea<CR>",
        mode = { "x" },
        desc = "Add cursors to the lines of the visual area"
      },
      {
        "<Leader>mm",
        "<Cmd>MultipleCursorsAddMatches<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword"
      },
      {
        "<Leader>mM",
        "<Cmd>MultipleCursorsAddMatchesV<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword in previous area"
      },
      {
        "<Leader>mn",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and jump to next cword"
      },
      {
        "<Leader>mN",
        "<Cmd>MultipleCursorsJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Jump to next cword"
      },
      {
        "<Leader>ml",
        "<Cmd>MultipleCursorsLock<CR>",
        mode = { "n", "x" },
        desc = "Lock virtual cursors"
      },
    },

  },
}
