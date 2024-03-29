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
                    "ast_grep",
                    "angularls",
                    "arduino_language_server",
                    "asm_lsp",
                    "bashls",
                    "clangd",
                    "csharp_ls",
                    "cssls",
                    "docker_compose_language_service",
                    "elixirls",
                    "gopls",
                    "gradle_ls",
                    "html",
                    "htmx",
                    --"hls",
                    "jsonls",
                    "jdtls", -- "java_language_server"
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
            vim.keymap.set("n", "<leader>fm",
                function()
                    vim.lsp.buf.format({ async = true })
                    vim.cmd("%retab")
                end,
                { noremap = true, silent = true, desc = "Format" })
            vim.keymap.set("n", "<leader>ci",
                function()
                    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
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
            vim.diagnostic.config({
                virtual_text = false,
            })
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

    -- Trouble
    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            position = "bottom", -- position of the list can be: bottom, top, left, right
            height = 10, -- height of the trouble list when position is top or bottom
            width = 50, -- width of the list when position is left or right
            icons = true, -- use devicons for filenames
            mode = "workspace_diagnostics", -- workspace_diagnostics, document_diagnostics, quickfix, lsp_references", "loclist"
            severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
            fold_open = "", -- icon used for open folds
            fold_closed = "", -- icon used for closed folds
            group = true, -- group results by file
            padding = true, -- add an extra new line on top of the list
            cycle_results = true, -- cycle item list when reaching beginning or end of list
            action_keys = { -- key mappings for actions in the trouble list
                -- map to {} to remove a mapping, for example:
                -- close = {},
                close = "q",      -- close the list
                cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                refresh = "r",    -- manually refresh
                jump = {
                    "<cr>",
                    "<tab>",
                    "<2-leftmouse>"
                },                            -- jump to the diagnostic or open / close folds
                open_split = { "<c-x>" },     -- open buffer in new split
                open_vsplit = { "<c-v>" },    -- open buffer in new vsplit
                open_tab = { "<c-t>" },       -- open buffer in new tab
                jump_close = { "o" },         -- jump to the diagnostic and close the list
                toggle_mode = "m",            -- toggle between "workspace" and "document" diagnostics mode
                switch_severity = "s",        -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
                toggle_preview = "P",         -- toggle auto_preview
                hover = "K",                  -- opens a small popup with the full multiline message
                preview = "p",                -- preview the diagnostic location
                open_code_href = "c",         -- if present, open a URI with more information about the diagnostic error
                close_folds = { "zM", "zm" }, -- close all folds
                open_folds = { "zR", "zr" },  -- open all folds
                toggle_fold = { "zA", "za" }, -- toggle fold of current file
                previous = "k",               -- previous item
                next = "j",                   -- next item
                help = "?",                   -- help menu
            },
            multiline = true,                 -- render multi-line messages
            indent_lines = true,              -- add an indent guide below the fold icons
            win_config = {
                border = "none"
            },                   -- window configuration for floating windows. See |nvim_open_win()|.
            auto_open = false,   -- automatically open the list when you have diagnostics
            auto_close = false,  -- automatically close the list when you have no diagnostics
            auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
            auto_fold = false,   -- automatically fold a file trouble list at creation
            auto_jump = {
                "lsp_definitions"
            }, -- for the given modes, automatically jump if there is only a single result
            include_declaration = {
                "lsp_references",
                "lsp_implementations",
                "lsp_definitions"
            }, -- for the given modes, include the declaration of the current symbol in the results
            signs = {
                -- icons / text used for a diagnostic
                error = "",
                warning = "",
                hint = "",
                information = "",
                other = "",
            },
            use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
        },

        config = function()
            require("trouble").setup()

            vim.keymap.set("n", "<leader>co", "<cmd>TroubleToggle<cr>",
                { noremap = true, silent = true, desc = "Toggle Diagnostics" })
        end
    }
}
