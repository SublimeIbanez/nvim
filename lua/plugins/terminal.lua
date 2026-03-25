return {
  -- ToggleTerm / Terminals
  {
    "akinsho/toggleterm.nvim",
    version = "*",

    config = function()
      require("toggleterm").setup({
        -- Can be a number or a function which passes the terminal
        size = function(term)
          if term.direction == "horizontal" then
            return math.floor(vim.o.lines * 0.3)
          elseif term.direction == "vertical" then
            return math.max(80, math.floor(vim.o.columns * 0.3))
          end
        end,
        -- open_mapping = [[<c-\>]],
        -- on_create = fun(t: Terminal), -- function to run when the terminal is first created
        -- on_open = fun(t: Terminal), -- function to run when the terminal opens
        -- on_close = fun(t: Terminal), -- function to run when the terminal closes
        -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
        -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
        -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
        -- hide_numbers = true, -- hide the number column in toggleterm buffers
        hide_numbers = false,
        -- shade_filetypes = {},
        -- autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
        -- highlights = {
        --   -- highlights which map to a highlight group name and a table of it's values
        --   -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
        --   Normal = {
        --     guibg = "<VALUE-HERE>",
        --   },
        --   NormalFloat = {
        --     link = 'Normal'
        --   },
        --   FloatBorder = {
        --     guifg = "<VALUE-HERE>",
        --     guibg = "<VALUE-HERE>",
        --   },
        -- },
        -- shading_factor = '<number>', -- the percentage by which to lighten dark terminal background, default: -30
        shading_factor = "25",
        -- shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
        -- shading_ratio = '<number>', -- the ratio of shading factor for light/dark terminal background, default: -3
        -- start_in_insert = true,
        -- insert_mappings = true, -- whether or not the open mapping applies in insert mode
        -- terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        -- persist_size = true,
        -- persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
        -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
        -- close_on_exit = true, -- close the terminal window when the process exits
        -- clear_env = false, -- use only environmental variables from `env`, passed to jobstart()
        -- shell = vim.o.shell, -- Change the default shell. Can be a string or a function returning a string
        -- auto_scroll = true, -- automatically scroll to the bottom on terminal output
        -- -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          border = "single",
          -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
          -- width = <value>,
          -- height = <value>,
          -- row = <value>,
          -- col = <value>,
          winblend = 20,
          -- zindex = <value>,
          -- title_pos = 'left' | 'center' | 'right', position of the title of the floating window
          title_pos = "left",
        },
        -- winbar = {
        --   enabled = true,
        --   name_formatter = function(term) --  term: Terminal
        --     return term.name
        --   end
        -- },
        -- responsiveness = {
        -- breakpoint in terms of `vim.o.columns` at which terminals will start to stack on top of each other
        -- instead of next to each other
        -- default = 0 which means the feature is turned off
        -- horizontal_breakpoint = function()
        --   return vim.o.columns * 0.2
        -- end,
        -- }
      })

      local term_api = require("toggleterm.terminal")

      -- -- Counts the number of terminals that exist
      local function CountTerms()
        return #term_api.get_all(true)
      end
      local function CurrentTerm()
        -- If inside term buffer
        local id, term = term_api.identify()
        if id and term then
          return term
        end

        -- Otherwise use currently focused/open terminal
        local focused_id = term_api.get_focused_id()
        if focused_id then
          local focused = term_api.get(focused_id, true)
          if focused then
            return focused
          end
        end

        -- Fallback: first open terminal
        local all = term_api.get_all(true)
        return all[1]
      end

      local function TermDirection()
        local term = CurrentTerm()
        if not term then
          return nil
        end

        return term.direction
      end

      local function AllowedNewDirection()
        local dir = TermDirection()

        -- Only allow split directions for "new"
        if dir == "vertical" or dir == "horizontal" then
          return dir
        end
        -- Fallback if current terminal is float/tab or no terminal exists
        return "horizontal"
      end

      local function NewTerminal()
        local dir = AllowedNewDirection()
        local termCount = CountTerms() + 1
        local command = termCount .. "ToggleTerm direction=" .. dir
        vim.cmd(command)
      end

      -- Floating terminal
      vim.keymap.set("n", "<c-]>", function()
        vim.cmd("ToggleTerm direction=float")
      end, { noremap = true, silent = true, desc = "Float" })
      vim.keymap.set("t", "<c-]>", function()
        vim.cmd("ToggleTerm")
      end, { noremap = true, silent = true, desc = "Close" })

      -- Vertical termianl
      vim.keymap.set("n", "<C-S-\\>", function()
        vim.cmd("ToggleTerm direction=vertical")

        local job = vim.b.terminal_job_id
        if job then
          vim.api.nvim_chan_send(job, "\x0c") -- Ctrl-L
        end
      end, { noremap = true, silent = true, desc = "Vertical" })
      vim.keymap.set("t", "<C-S-\\>", function()
        vim.cmd("ToggleTerm")
      end, { noremap = true, silent = true, desc = "Close" })

      -- Horizontal terminal
      vim.keymap.set("n", "<c-\\>", function()
        vim.cmd("ToggleTerm direction=horizontal")
      end, { noremap = true, silent = true, desc = "Horizontal" })
      vim.keymap.set("t", "<c-\\>", function()
        vim.cmd("ToggleTerm")
      end, { noremap = true, silent = true, desc = "Close" })

      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]],
        { noremap = true, silent = true, desc = "terminal -> normal" })

      -- Create new terminals
      vim.keymap.set("n", "<leader>tn", function()
        NewTerminal()
      end, { noremap = true, silent = true, desc = "New" })
      vim.keymap.set("t", "<C-S-=>", function()
        NewTerminal()
      end, { noremap = true, silent = true, desc = "New" })

      -- Close current terminal
      vim.keymap.set("n", "<leader>te", function()
        if CountTerms() == 0 then
          return ""
        end
        vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
      end, { noremap = true, silent = true, desc = "Exit" })
      vim.keymap.set("t", "<C-S-->", function()
        if CountTerms() == 0 then
          return ""
        end
        vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
      end, { noremap = true, silent = true, desc = "Exit" })
    end,
  },
}
