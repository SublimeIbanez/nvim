return {
  { "echasnovski/mini.nvim", version = false, config = function() require("mini.icons").setup() end },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    config = function()
      local status_ok, which_key = pcall(require, "which-key")
      if not status_ok then
        return
      end
      -- Set timeout
      vim.o.timeout = true
      vim.o.timeoutlen = 50

      -- Custom setup
      local setup = {
        preset = "classic", -- false | "classic" | "modern" | "helix"
        plugins = {
          marks = true,     -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          spelling = {
            enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          presets = {
            operators = true,    -- adds help for operators like d, y, ...
            motions = true,      -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true,      -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = true,            -- bindings for folds, spelling and others prefixed with z
            g = true,            -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        defer = {
          gc = "Comments"
        },
        replace = {}, -- key_labels
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        keys = { -- popup_mappings
          scroll_down = "<c-d>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
          border = "none",            -- none, single, double, shadow
          position = "bottom",        -- bottom, top
          margin = { 1, 0, 1, 0.55 }, -- [top, right, bottom, left]. Between 0 and 1 will be treated as a percentage
          padding = { 1, 2, 1, 2 },   -- extra window padding [top, right, bottom, left]
          winblend = 20,              -- value between 0-100 0 for fully opaque and 100 for fully transparent
          zindex = 1000,              -- positive value to position WhichKey above other floating windows.
        },
        layout = {
          height = {
            min = 4,
            max = 50,
          }, -- min and max height of the columns
          width = {
            min = 20,
            max = 50,
          },              -- min and max width of the columns
          spacing = 1,    -- spacing between columns
          align = "left", -- align columns left, center or right
        },
        show_help = true, -- show a help message in the command line for using WhichKey
        show_keys = true, -- show the currently pressed key and its label as a message in the command line
        triggers = {
          {
            mode = { "n" },
            { " ",  expr = false,       group = "Space",      nowait = false, remap = false },
            { " ?", desc = "Help",      expr = false,         nowait = false, remap = false },
            { " c", expr = false,       group = "Code",       nowait = false, remap = false },
            { " d", desc = "Debug",     expr = false,         nowait = false, remap = false },
            { " e", desc = "Exit",      expr = false,         nowait = false, remap = false },
            { " f", desc = "File",      expr = false,         nowait = false, remap = false },
            { " h", desc = "Highlight", expr = false,         nowait = false, remap = false },
            { " n", desc = "Swap",      expr = false,         nowait = false, remap = false },
            { " p", desc = "Open",      expr = false,         nowait = false, remap = false },
            { " t", desc = "Terminal",  expr = false,         nowait = false, remap = false },
            { " w", desc = "Workspace", expr = false,         nowait = false, remap = false },
            { " y", desc = "Yank",      expr = false,         nowait = false, remap = false },
            { "g",  expr = false,       group = "Goto",       nowait = false, remap = false },
            { "[",  expr = false,       group = "Diagnostic", nowait = false, remap = false },
            { "]",  expr = false,       group = "Diagnostic", nowait = false, remap = false },
          },
          {
            mode = { "v" },
            { " ",  expr = false,  group = "Space", nowait = false, remap = false },
            { " ?", desc = "Help", expr = false,    nowait = false, remap = false },
            { " c", expr = false,  group = "Code",  nowait = false, remap = false },
            { " p", desc = "Open", expr = false,    nowait = false, remap = false },
            { " y", desc = "Yank", expr = false,    nowait = false, remap = false },
            { "g",  expr = false,  group = "Goto",  nowait = false, remap = false },
          },

        }, -- or specifiy a list manually
        disable = {
          buftypes = {},
          filetypes = {},
        },
      }
      which_key.setup(setup)
    end
  },
}
