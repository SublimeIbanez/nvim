return {
  -- Connect to and setup the LSP servers
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "mason-org/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      -- mason-lspconfig:
      -- - Bridges the gap between LSP config names (e.g. "lua_ls") and actual Mason package names (e.g. "lua-language-server").
      -- - Used here only to allow specifying language servers by their LSP name (like "lua_ls") in `ensure_installed`.
      -- - It does not auto-configure servers — we use vim.lsp.config() + vim.lsp.enable() explicitly for full control.
      "mason-org/mason-lspconfig.nvim",
      -- mason-tool-installer:
      -- - Installs LSPs, linters, formatters, etc. by their Mason package name.
      -- - We use it to ensure all desired tools are present.
      -- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 20, -- Background color opacity in the notification window
            },
          },
        },
      },

      -- Allows extra capabilities provided by nvim-cmp
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      -- LSP servers and clients are able to communicate to each other what features they support.
      -- By default, Neovim doesn't support everything that is in the LSP specification.
      -- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      -- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      capabilities.textDocument.inlayHint = {
        dynamicRegistration = false,
      }
      -- local lspconfig = require("lspconfig")
      -- require("cmp_nvim_lsp").default_capabilities()
      local servers = {
        -------------------------------------------------------------------------------------------
        --- angularls
        -------------------------------------------------------------------------------------------
        angularls = {},

        -------------------------------------------------------------------------------------------
        --- arduino_language_server
        -------------------------------------------------------------------------------------------
        arduino_language_server = {},

        -------------------------------------------------------------------------------------------
        --- bashls
        -------------------------------------------------------------------------------------------
        bashls = {},

        -------------------------------------------------------------------------------------------
        --- clangd
        -------------------------------------------------------------------------------------------
        clangd = {
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
          },
        },

        -------------------------------------------------------------------------------------------
        --- omnisharp
        --- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/omnisharp.lua
        -------------------------------------------------------------------------------------------
        omnisharp = {
          cmd = {
            vim.fn.executable("OmniSharp") == 1 and "OmniSharp" or "omnisharp",
            "-z", -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
            "--hostPID",
            tostring(vim.fn.getpid()),
            "DotNet:enablePackageRestore=false",
            "--encoding",
            "utf-8",
            "--languageserver",
          },
          root_markers = { "*.sln", "*.slnx", "*.csproj", ".git" },
          filetypes = { "cs", "vb" },
          init_options = {},
          capabilities = {
            workspace = {
              workspaceFolders = false, -- https://github.com/OmniSharp/omnisharp-roslyn/issues/909
            },
          },
          settings = {
            FormattingOptions = {
              -- Enables support for reading code style, naming convention and analyzer settings from .editorconfig.
              EnableEditorConfigSupport = true,
              -- Specifies whether 'using' directives should be grouped and sorted during document formatting.
              OrganizeImports = true,
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
              -- Only run analyzers against open files when 'EnableRoslynAnalyzers' is
              -- true
              AnalyzeOpenDocumentsOnly = nil,
              EnableDecompilationSupport = true,
              DiagnosticWorkersThreadCount = 100,
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
                forImplicitObjectCreation = true,
              },
            },
            Sdk = {
              -- Specifies whether to include preview versions of the .NET SDK when
              -- determining which version to use for project loading.
              IncludePrereleases = true,
            },
          },
        },
        cssls = {},
        docker_compose_language_service = {},
        lexical = {},
        gopls = {},
        html = {},
        htmx = {},
        jsonls = {},
        jdtls = {},
        ts_ls = {
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
        },
        lua_ls = {},
        marksman = {},
        pylsp = {},
        rust_analyzer = {
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
                enable = true,
              },
            },
          },
          capabilities = capabilities,
        },
        sqls = {},
        slint_lsp = {},
        svelte = {},
        taplo = {},
        tailwindcss = {},
        zls = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {})
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      for server, cfg in pairs(servers) do
        -- For each LSP server (cfg), we merge:
        -- 1. A fresh empty table (to avoid mutating capabilities globally)
        -- 2. Your capabilities object with Neovim + cmp features
        -- 3. Any server-specific cfg.capabilities if defined in `servers`
        cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

        vim.lsp.config(server, cfg)
        vim.lsp.enable(server)
      end

      -- global kepmaps
      vim.lsp.inlay_hint.enable(true)
    end,
  },

  -- conform formatter
  {
    "stevearc/conform.nvim",

    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },

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
          cs = { "omnisharp" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = nil,
      })

      vim.keymap.set("n", "grfm", function()
        conform.format({ async = true })
      end, { noremap = true, silent = true, desc = "Format" })
    end,
  },

  -- Error mapping -- lines
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

    config = function()
      local lines = require("lsp_lines")
      lines.setup()

      -- Disable virtual_text since it's redundant due to lsp_lines
      vim.diagnostic.config({
        virtual_text = false,
      })

      -- UNCOMMENT TO DISABLE LINES AT START
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          lines.toggle()
        end,
      })

      -- Toggle inlay
      function ToggleInlay()
        local current_config = vim.diagnostic.config()
        local enabled = not (current_config.virtual_text == false)
        vim.diagnostic.config({ virtual_text = not enabled })
      end

      -- Change error display from lines to inlay
      vim.keymap.set({ "n", "v" }, "gres", function()
        -- Toggle under lines
        lines.toggle()
        -- Toggle inlay error
        ToggleInlay()
      end, { noremap = true, silent = true, desc = "Switch Error Display" })

      -- Turn off lines
      vim.keymap.set({ "n", "v" }, "gree", function()
        lines.toggle()
      end, { noremap = true, silent = true, desc = "Toggle Lines Error" })

      -- Action to toggle inline error alone
      vim.keymap.set(
        { "n", "v" },
        "gret",
        ToggleInlay,
        { noremap = true, silent = true, desc = "Toggle Inline Error" }
      )
    end,
  },
}
