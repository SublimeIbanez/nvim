return {
  -- Completions CMP
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      "saadparwaiz1/cmp_luasnip",

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },

    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind");
      require("luasnip.loaders.from_vscode").lazy_load()

      local highlightgroups = {
        PmenuSel = { fg = "#64ffda", bg = "#232323" },
        Pmenu = { fg = "#C5CDD9", bg = "NONE" },
        CmpBorder = { fg = "#ffffff", bg = "#22252A" },
        CmpDocBorder = { fg = "#ffffff", bg = "#22252A" },

        CmpItemAbbrDeprecated = { fg = "#7E8294", strikethrough = true },
        CmpItemAbbrMatch = { fg = "#82AAFF", bold = true },
        CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
        CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic = true },

        CmpItemKindField = { fg = "#EED8DA", bg = "NONE" },
        CmpItemKindProperty = { fg = "#EED8DA", bg = "NONE" },
        CmpItemKindEvent = { fg = "#EED8DA", bg = "NONE" },

        CmpItemKindText = { fg = "#C3E88D", bg = "NONE" },
        CmpItemKindEnum = { fg = "#C3E88D", bg = "NONE" },
        CmpItemKindKeyword = { fg = "#C3E88D", bg = "NONE" },

        CmpItemKindConstant = { fg = "#FFE082", bg = "NONE" },
        CmpItemKindConstructor = { fg = "#FFE082", bg = "NONE" },
        CmpItemKindReference = { fg = "#FFE082", bg = "NONE" },

        CmpItemKindFunction = { fg = "#EADFF0", bg = "NONE" },
        CmpItemKindStruct = { fg = "#EADFF0", bg = "NONE" },
        CmpItemKindClass = { fg = "#EADFF0", bg = "NONE" },
        CmpItemKindModule = { fg = "#EADFF0", bg = "NONE" },
        CmpItemKindOperator = { fg = "#EADFF0", bg = "NONE" },

        CmpItemKindVariable = { fg = "#C5CDD9", bg = "NONE" },
        CmpItemKindFile = { fg = "#C5CDD9", bg = "NONE" },

        CmpItemKindUnit = { fg = "#F5EBD9", bg = "NONE" },
        CmpItemKindSnippet = { fg = "#F5EBD9", bg = "NONE" },
        CmpItemKindFolder = { fg = "#F5EBD9", bg = "NONE" },

        CmpItemKindMethod = { fg = "#DDE5F5", bg = "NONE" },
        CmpItemKindValue = { fg = "#DDE5F5", bg = "NONE" },
        CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "NONE" },

        CmpItemKindInterface = { fg = "#D8EEEB", bg = "NONE" },
        CmpItemKindColor = { fg = "#D8EEEB", bg = "NONE" },
        CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "NONE" },
      }

      for group, setting in pairs(highlightgroups) do
        vim.api.nvim_set_hl(0, group, setting)
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        formatting = {
          fields = { "icon", "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            local kind = lspkind.cmp_format({ mode = "symbol_text" })(entry, vim_item)
            kind.icon = " " .. (kind.icon or "") .. " "
            kind.kind = "  (" .. (kind.kind or "") .. ")"

            return kind
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
            col_offset = -3,
            side_padding = 2,
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:CmpDocBorder,Search:None",
            side_padding = 5,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<S-tab>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<tab>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<Up>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<Down>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-space>"] = cmp.mapping.abort(-4),
          ["<CR>"] = function(fallback)
            if cmp.visible() then
              if cmp.get_selected_entry() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                })
              else
                fallback()
              end
            else
              fallback()
            end
          end,
        }),
        sources = cmp.config.sources({
          --   { name = "luasnip" },
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
