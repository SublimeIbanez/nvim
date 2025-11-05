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
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
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
        format_on_save = nil,
        -- format_on_save = {
        --   lsp_fallback = false,
        --   async = false,
        --   timeout_ms = 500,
        -- },
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
          -- "csharp_ls",
          "omnisharp",
          "cssls",
          "docker_compose_language_service",
          "elixirls",
          "gopls",
          "gradle_ls",
          "html",
          --"htmx",
          --"hls",
          "jsonls",
          "jdtls", -- "java_language_server"
          "ts_ls", -- "tsserver" (deprecated?),
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
      capabilities.textDocument.inlayHint = {
        dynamicRegistration = false
      }
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
        settings = {
          c = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },

          cpp = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },
        }
      })
      -- lspconfig.csharp_ls.setup({
      --   cmd = { "csharp-ls" },
      --   capabilities = capabilities,
      -- })
      lspconfig.omnisharp.setup({
        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        capabilities = capabilities,
        settings = {
          FormattingOptions = {
            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            EnableEditorConfigSupport = true,
            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            OrganizeImports = nil,
          },
          MsBuild = {
            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            LoadProjectsOnDemand = nil,
          },
          RoslynExtensionsOptions = {
            UseTestingPlatformProtocol = true,
            -- Enables support for roslyn analyzers, code fixes and rulesets.
            EnableAnalyzersSupport = true,
            -- Enables support for showing unimported types and unimported extension
            -- methods in completion lists. When committed, the appropriate using
            -- directive will be added at the top of the current file. This option can
            -- have a negative impact on initial completion responsiveness,
            -- particularly for the first few completion sessions after opening a
            -- solution.
            EnableImportCompletion = true,
            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            -- true
            AnalyzeOpenDocumentsOnly = nil,
            EnableDecompilationSupport = true,
            DiagnosticWorkersThreadCount = 10,
            -- InlayHints control
            inlayHintsOptions = {
              enableForParameters = true,
              forLiteralParameters = true,
              forIndexerParameters = true,
              forObjectCreationParameters = true,
              forOtherParameters = true,
              suppressForParametersThatDifferOnlyBySuffix = false,
              suppressForParametersThatMatchMethodIntent = false,
              suppressForParametersThatMatchArgumentName = false,
              enableForTypes = true,
              forImplicitVariableTypes = true,
              forLambdaParameterTypes = true,
              forImplicitObjectCreation = true
            },
          },
          Sdk = {
            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            IncludePrereleases = true,
          },
        }
      })
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
      --lspconfig.java_language_server.setup({})
      lspconfig.jdtls.setup({
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        settings = {

          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },

          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },
        },
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
            inlayHints = {
              enable = true
            }
          },
        },
        capabilities = capabilities,
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
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { 0 })
        end,
        { noremap = true, silent = true, desc = "Toggle Inlay Hints" })
      vim.lsp.inlay_hint.enable(true)
    end,
  },

  -- CSharp
  -- {
  --   "iabdelkareem/csharp.nvim",
  --   dependencies = {
  --     "williamboman/mason.nvim", -- Required, automatically installs omnisharp
  --     "mfussenegger/nvim-dap",
  --     "Tastyep/structlog.nvim",  -- Optional, but highly recommended for debugging
  --   },
  --   config = function()
  --     require("mason").setup() -- Mason setup must run before csharp, only if you want to use omnisharp
  --     require("csharp").setup(
  --       {
  --         lsp = {
  --           -- Sets if you want to use omnisharp as your LSP
  --           omnisharp = {
  --             -- When set to false, csharp.nvim won't launch omnisharp automatically.
  --             enable = true,
  --             -- When set, csharp.nvim won't install omnisharp automatically. Instead, the omnisharp instance in the cmd_path will be used.
  --             cmd_path = nil,
  --             -- The default timeout when communicating with omnisharp
  --             default_timeout = 1000,
  --             -- Settings that'll be passed to the omnisharp server
  --             enable_editor_config_support = true,
  --             organize_imports = true,
  --             load_projects_on_demand = false,
  --             enable_analyzers_support = true,
  --             enable_import_completion = true,
  --             include_prerelease_sdks = true,
  --             analyze_open_documents_only = false,
  --             enable_package_auto_restore = true,
  --             -- Launches omnisharp in debug mode
  --             debug = false,
  --           },
  --           -- Sets if you want to use roslyn as your LSP
  --           roslyn = {
  --             -- When set to true, csharp.nvim will launch roslyn automatically.
  --             enable = true,
  --             -- Path to the roslyn LSP see 'Roslyn LSP Specific Prerequisites' above.
  --             cmd_path = nil,
  --           },
  --           -- The capabilities to pass to the omnisharp server
  --           capabilities = nil,
  --           -- on_attach function that'll be called when the LSP is attached to a buffer
  --           on_attach = nil
  --         },
  --         logging = {
  --           -- The minimum log level.
  --           level = "INFO",
  --         },
  --         dap = {
  --           -- When set, csharp.nvim won't launch install and debugger automatically. Instead, it'll use the debug adapter specified.
  --           --- @type string?
  --           adapter_name = nil,
  --         }
  --       }
  --     )
  --   end
  -- },

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
