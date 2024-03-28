return {
    {
        "mfussenegger/nvim-dap",

        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "leoluz/nvim-dap-go",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            -- Adapter / Config
            -- Golang
            require("dap-go").setup()

            -- C / C++ / Rust
            dap.adapters.lldb = {
                name = "lldb",
                type = "executable",
                command = "/usr/bin/lldb-dap-18", -- Must be absolute path
            }
            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtEntry = true,
                    setupCommands = {
                        {
                            text = '-enable-pretty-printing',
                            description = 'enable pretty printing',
                            ignoreFailures = false
                        },
                    },
                },
            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp


            -- Keymap
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint,
                { noremap = true, silent = true, desc = "Breakpoint" })
            vim.keymap.set("n", "<leader>dd", dap.continue,
                { noremap = true, silent = true, desc = "Start/Stop/Continue" })
            vim.keymap.set("n", "<leader>dt", dapui.toggle,
                { noremap = true, silent = true, desc = "ToggleUI" })
        end,
    },
}
