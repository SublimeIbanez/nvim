return {
  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",

    config = function()
      local bufferline = require("bufferline")
      local function is_neo_tree(bufnr)
        local ft = vim.bo[bufnr].filetype
        return ft == "neo-tree" or ft == "neo-tree-popup" or ft == "neo-tree-preview"
      end

      local function is_real_file_buf(bufnr)
        if not vim.api.nvim_buf_is_valid(bufnr) then return false end
        if vim.fn.buflisted(bufnr) ~= 1 then return false end
        if is_neo_tree(bufnr) then return false end
        if vim.bo[bufnr].buftype ~= "" then return false end -- skip nofile/terminal/quickfix/etc
        return true
      end
      --
      local function mru_real_buffer(exclude_bufnr)
        local infos = vim.fn.getbufinfo({ buflisted = 1 })
        table.sort(infos, function(a, b) return (a.lastused or 0) > (b.lastused or 0) end)

        for _, info in ipairs(infos) do
          local b = info.bufnr
          if b ~= exclude_bufnr and is_real_file_buf(b) then
            return b
          end
        end
        return nil
      end
      --
      -- local function smart_bdelete(bufnr, force)
      --   bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
      --   force = force == true
      --
      --   local cur = vim.api.nvim_get_current_buf()
      --
      --   -- If we're deleting a non-current buffer, don't change focus.
      --   if bufnr ~= cur then
      --     vim.api.nvim_buf_delete(bufnr, { force = force })
      --     return
      --   end
      --
      --   -- Prefer alternate buffer (#) if it's a real file buffer and not neo-tree
      --   local alt = vim.fn.bufnr("#")
      --   local target = (alt > 0 and alt ~= bufnr and is_real_file_buf(alt)) and alt or mru_real_buffer(bufnr)
      --
      --   -- If nothing else exists, create an empty buffer so we don't land in neo-tree.
      --   if not target then
      --     vim.cmd("Dashboard")
      --     target = vim.api.nvim_get_current_buf()
      --   else
      --     vim.api.nvim_set_current_buf(target)
      --   end
      --
      --   vim.api.nvim_buf_delete(bufnr, { force = force })
      -- end
      local function open_fallback_buffer()
        -- Prefer your dashboard if the command exists; otherwise just make an empty buffer.
        if vim.fn.exists(":Dashboard") == 2 then
          pcall(vim.cmd, "silent! Dashboard")
          return vim.api.nvim_get_current_buf()
        end

        vim.cmd("enew")
        return vim.api.nvim_get_current_buf()
      end

      local function smart_bdelete(bufnr, force)
        bufnr = (bufnr == 0) and vim.api.nvim_get_current_buf() or bufnr
        force = (force == true)

        if not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end

        local cur = vim.api.nvim_get_current_buf()

        -- If we're deleting a non-current buffer, don't change focus.
        if bufnr ~= cur then
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(bufnr) then
              vim.api.nvim_buf_delete(bufnr, { force = force })
            end
          end)
          return
        end

        -- Prefer alternate buffer (#) if it's a real file buffer and not neo-tree
        local alt = vim.fn.bufnr("#")
        local target = (alt > 0 and alt ~= bufnr and is_real_file_buf(alt)) and alt or mru_real_buffer(bufnr)

        if target and vim.api.nvim_buf_is_valid(target) then
          vim.api.nvim_set_current_buf(target)
        else
          open_fallback_buffer()
        end

        -- Delete on the next tick to avoid UI callback weirdness / “hangs”
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(bufnr) then
            vim.api.nvim_buf_delete(bufnr, { force = force })
          end
        end)
      end



      bufferline.setup({
        options = {
          mode = "buffers", -- set to "tabs" to only show tabpages instead
          style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
          themable = true, -- | false, -- allows highlight groups to be overriden i.e. sets highlights as default
          numbers = "ordinal", -- | "none" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
          close_command = function(bufnr) smart_bdelete(bufnr, true) end, -- can be a string | function, | false see "Mouse actions"
          right_mouse_command = function(bufnr) smart_bdelete(bufnr, true) end, -- can be a string | function | false, see "Mouse actions"
          left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
          middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
          indicator = {
            icon = "▎", -- this should be omitted if indicator style is not 'icon'
            style = "icon", -- | 'underline' | 'none',
          },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          --- name_formatter can be used to change the buffer's label in the bufferline.
          --- Please note some names can/will break the
          --- bufferline so use this at your discretion knowing that it has
          --- some limitations that will *NOT* be fixed.
          --  name_formatter = function(_)   -- (buf) contains:
          --     -- name                | str        | the basename of the active file
          --     -- path                | str        | the full path of the active file
          --     -- bufnr (buffer only) | int        | the number of the active buffer
          --     -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
          --     -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using:
          --                                               `vim.api.nvim_tabpage_get_number(buf.tabnr)`
          -- end,
          max_name_length = 18,
          -- max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
          -- truncate_names = true, -- whether or not tab names should be truncated
          tab_size = 18,
          diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
          -- diagnostics_update_in_insert = false,
          -- -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
          -- diagnostics_indicator = function(count, _, _, _) --level, diagnostics_dict, context
          --     return "("..count..")"
          -- end,
          -- -- NOTE: this will be called a lot so don't do any heavy processing here
          -- custom_filter = function(buf_number, buf_numbers)
          --     -- filter out filetypes you don't want to see
          --     if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
          --         return true
          --     end
          --     -- filter out by buffer name
          --     if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
          --         return true
          --     end
          --     -- filter out based on arbitrary rules
          --     -- e.g. filter out vim wiki buffer from tabline in your work repo
          --     if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
          --         return true
          --     end
          --     -- filter out by it's index number in list (don't show first buffer)
          --     if buf_numbers[1] ~= buf_number then
          --         return true
          --     end
          -- end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer", --| function ,
              text_align = "left",    -- | "left" | "right" | center
              separator = false,
            },
          },
          color_icons = true, -- | false, -- whether or not to add the filetype icon highlights
          -- get_element_icon = function(element)
          --     -- element consists of {filetype: string, path: string, extension: string, directory: string}
          --     -- This can be used to change how bufferline fetches the icon
          --     -- for an element e.g. a buffer or a tab.
          --     -- e.g.
          --     local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          --     return icon, hl
          --     -- or
          --     -- local custom_map = {my_thing_ft: {icon = "my_thing_icon", hl}}
          --     -- return custom_map[element.filetype]
          -- end,
          -- show_buffer_icons = true, -- | false, -- disable filetype icons for buffers
          show_buffer_close_icons = true, -- | false,
          show_close_icon = true,         -- | false,
          show_tab_indicators = true,     -- | false,
          -- show_duplicate_prefix = true, -- | false, -- whether to show duplicate buffer prefix
          -- duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
          -- persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          -- move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
          -- -- can also be a table containing 2 custom separators
          -- -- [focused and unfocused]. eg: { '|', '|' }
          separator_style = "slant",     -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
          -- enforce_regular_tabs = false, -- | true,
          always_show_bufferline = true, -- | false,
          hover = {
            enabled = false,
            delay = 200,
            reveal = { 'close' }
          },

          -- sort_by = ...
          -- insert_at_end, insert_after_current, id, extension, relative_directory, directory, tabs,
          -- function(buffer_a, buffer_b)
          -- add custom logic
          -- return buffer_a.modified > buffer_b.modified
          sort_by = "id",
        },
      })

      vim.keymap.set("n", "<D-.>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
      vim.keymap.set("n", "<D-,>", ":BufferLineCyclePrev<CR>",
        { noremap = true, silent = true, desc = "Previous Buffer" })
      vim.keymap.set("n", "<A-.>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
      vim.keymap.set("n", "<A-,>", ":BufferLineCyclePrev<CR>",
        { noremap = true, silent = true, desc = "Previous Buffer" })
      vim.keymap.set("n", "<leader>pq", function() smart_bdelete(0, false) end,
        { noremap = true, silent = true, desc = "Close Current Buffer" })
    end,
  },
}
