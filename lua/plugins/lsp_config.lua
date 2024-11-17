return {
  -- Connection with the lsp base
  {
    "williamboman/mason.nvim",

    config = function()
      require("mason").setup()
    end,
  },

  -- conform formatter
  {
    "stevearc/conform.nvim",

    event = { "BufReadPre", "BufNewFile" },

    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
      })

      vim.keymap.set("n", "<leader>fm",
        function()
          conform.format({ async = true })
        end,
        { noremap = true, silent = true, desc = "Format" })
    end,
  },

  -- Add LSP configurations
  {
    "williamboman/mason-lspconfig.nvim",

    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ast_grep",
          "angularls",
          "arduino_language_server",
          --"asm_lsp",
          "bashls",
          "clangd",
          --"csharp_ls",
          "cssls",
          "docker_compose_language_service",
          "elixirls",
          "gopls",
          "gradle_ls",
          "html",
          --"htmx",
          --"hls",
          "jsonls",
          "jdtls",           -- "java_language_server"
          "tsserver",
          "kotlin_language_server",
          --"ltex",
          "lua_ls",
          "marksman",
          --"ocamllsp",
          "powershell_es",
          "pylsp",
          "rust_analyzer",
          "sqls",
          "slint_lsp",
          "svelte",
          "taplo",
          "tailwindcss",
          "zls",
        },
      })
    end,
  },

  -- Connect to and setup the LSP servers
  {
    "neovim/nvim-lspconfig",

    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.angularls.setup({
        capabilities = capabilities,
      })
      lspconfig.arduino_language_server.setup({
        capabilities = capabilities,
      })
      -- lspconfig.asm_lsp.setup({
      --     capabilities = capabilities,
      -- })
      lspconfig.bashls.setup({
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })
      -- lspconfig.csharp_ls.setup({
      --     capabilities = capabilities,
      -- })
      -- lspconfig.omnisharp.setup({
      --     capabilities = capabilities,
      -- })
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
      lspconfig.docker_compose_language_service.setup({
        capabilities = capabilities,
      })
      lspconfig.lexical.setup({
        capabilities = capabilities,
      })
      --lspconfig.erlangls.setup({
      --capabilities = capabilities
      --})
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })
      lspconfig.gradle_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      -- lspconfig.htmx.setup({
      --     capabilities = capabilities,
      -- })
      --lspconfig.hls.setup({
      --capabilities = capabilities
      --})
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
      lspconfig.jdtls.setup({       --lspconfig.java_language_server.setup({
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })
      lspconfig.kotlin_language_server.setup({
        capabilities = capabilities,
      })
      -- lspconfig.ltex.setup({
      --     capabilities = capabilities,
      -- })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.marksman.setup({
        capabilities = capabilities,
      })
      --lspconfig.ocamllsp.setup({
      --capabilities = capabilities
      --})
      lspconfig.powershell_es.setup({
        capabilities = capabilities,
      })
      lspconfig.pylsp.setup({
        capabilities = capabilities,
      })

      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
              importPrefix = "by_self",
            },
            cargo = {
              loadOutDirsFromCheck = true,
            },
            procMacro = {
              enable = true,
            },
          },
        },
        --capabilities = capabilities,
      })
      lspconfig.sqls.setup({
        capabilities = capabilities,
      })
      lspconfig.slint_lsp.setup({
        capabilities = capabilities,
      })
      lspconfig.svelte.setup({
        capabilities = capabilities,
      })
      lspconfig.taplo.setup({
        capabilities = capabilities,
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })
      lspconfig.zls.setup({
        capabilities = capabilities,
      })

      -- global kepmaps
      vim.keymap.set("n", "<leader>ck", vim.lsp.buf.hover,
        { noremap = true, silent = true, desc = "Display LSP Info" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition,
        { noremap = true, silent = true, desc = "Definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
        { noremap = true, silent = true, desc = "Declaration" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references,
        { noremap = true, silent = true, desc = "References" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
        { noremap = true, silent = true, desc = "Code Actions" })
      vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float,
        { noremap = true, silent = true, desc = "Hover Diagnostics" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
        { noremap = true, silent = true, desc = "Prev Diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next,
        { noremap = true, silent = true, desc = "Next Diagnostic" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
        { noremap = true, silent = true, desc = "Implementation" })
      vim.keymap.set("n", "gs", vim.lsp.buf.signature_help,
        { noremap = true, silent = true, desc = "Signature Help" })
      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
        { noremap = true, silent = true, desc = "Add Workspace Dir" })
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
        { noremap = true, silent = true, desc = "Remove Workspace Dir" })
      vim.keymap.set("n", "<leader>wl",
        function()
          vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        { noremap = true, silent = true, desc = "List Workspace Folders" })
      vim.keymap.set("n", "<leader>cD", vim.lsp.buf.type_definition,
        { noremap = true, silent = true, desc = "Type Definition" })
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename,
        { noremap = true, silent = true, desc = "Rename" })
      vim.keymap.set("n", "<leader>ci",
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
        end,
        { noremap = true, silent = true, desc = "Toggle Inlay Hints" })
    end,
  },

  -- Error mapping -- lines
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

    config = function()
      local lines = require("lsp_lines")
      lines.setup()

      -- Disable inlay error
      -- COMMENT TO ENABLE INLAY ERROR AT START
      vim.diagnostic.config({
        virtual_text = false,
      })

      -- UNCOMMENT TO DISABLE LINES AT START
      -- vim.api.nvim_create_autocmd("VimEnter", {
      --     callback = function()
      --         lines.toggle()
      --     end
      -- })

      -- Toggle inlay
      function ToggleInlay()
        local current_config = vim.diagnostic.config()
        local enabled = not (current_config.virtual_text == false)
        vim.diagnostic.config({ virtual_text = not enabled })
      end

      -- Change error display from lines to inlay
      vim.keymap.set({ "n", "v" }, "<leader>cs",
        function()
          -- Toggle under lines
          lines.toggle()
          -- Toggle inlay error
          ToggleInlay()
        end,
        { noremap = true, silent = true, desc = "Switch Error Display" })

      -- Turn off lines
      vim.keymap.set({ "n", "v" }, "<leader>ce", function() lines.toggle() end,
        { noremap = true, silent = true, desc = "Toggle Lines Error" })

      -- Action to toggle inline error alone
      vim.keymap.set(
        { "n", "v" },
        "<leader>ct",
        ToggleInlay,
        { noremap = true, silent = true, desc = "Toggle Inline Error" }
      )
    end,
  },
}
