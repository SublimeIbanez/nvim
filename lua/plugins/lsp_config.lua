return {
    -- Connection with the lsp base
    {
        "williamboman/mason.nvim",

        config = function()
            require("mason").setup()
        end,
    },

    -- Add LSP configurations
    {
        "williamboman/mason-lspconfig.nvim",

        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "angularls",
                    "arduino_language_server",
                    "asm_lsp",
                    "bashls",
                    "clangd",
                    "csharp_ls",
                    "cssls",
                    "docker_compose_language_service",
                    "elixirls",
                    --"erlangls",
                    "gopls",
                    "gradle_ls",
                    "html",
                    "htmx",
                    --"hls",
                    "jsonls",
                    "jdtls", -- "java_language_server"
                    "tsserver",
                    "kotlin_language_server",
                    "ltex",
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
            lspconfig.asm_lsp.setup({
                capabilities = capabilities,
            })
            lspconfig.bashls.setup({
                capabilities = capabilities,
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.csharp_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.cssls.setup({
                capabilities = capabilities,
            })
            lspconfig.docker_compose_language_service.setup({
                capabilities = capabilities,
            })
            lspconfig.elixirls.setup({
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
            lspconfig.htmx.setup({
                capabilities = capabilities,
            })
            --lspconfig.hls.setup({
            --capabilities = capabilities
            --})
            lspconfig.jsonls.setup({
                capabilities = capabilities,
            })
            lspconfig.jdtls.setup({ --lspconfig.java_language_server.setup({
                capabilities = capabilities,
            })
            lspconfig.tsserver.setup({
                capabilities = capabilities,
            })
            lspconfig.kotlin_language_server.setup({
                capabilities = capabilities,
            })
            lspconfig.ltex.setup({
                capabilities = capabilities,
            })
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
                            enable = true
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
            vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
            vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<space>cd", vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
            vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, {})
            vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, {})
            vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, {})
            vim.keymap.set("n", "<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, {})
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {})
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<c-F>", function()
                vim.lsp.buf.format({ async = true })
            end, {})
            vim.keymap.set("n", "<leader>ih", function()
                vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
            end, {})
        end,
    },

    -- Error mapping -- lines
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

        config = function()
            require("lsp_lines").setup()
            vim.keymap.set("", "<leader>le", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
            vim.diagnostic.config({
                virtual_text = false,
            })
        end,
    },
}
