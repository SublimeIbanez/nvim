return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",

    config = function()
        local config = {
            --header -- type is table def
            week_header = {
                enable = true,    --boolean use a week header
                concat = "",      --concat string after time string line
                append = {},      --table append after time string line
            },
            disable_move = false, -- boolean default is false disable move key
            shortcut = {
                {
                    -- action can be a function type
                    desc = "Open Dashboard",
                    group = "",
                    key = "<leader>pd",
                    action = ":Dashboard<cr>"
                },
            },
            packages = { -- show how many plugins neovim loaded
                enable = true
            },
            -- limit how many projects list, action when you press key or enter it will run this action.
            -- action can be a functino type, e.g.
            -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
            -- project = {
            --     enable = false,
            --     limit = 8,
            --     icon = 'your icon',
            --     label = "",
            --     action = ""
            -- },
            -- mru = {
            --     limit = 10,
            --     icon = 'your icon',
            --     label = '',
            --     cwd_only = false
            -- },
            footer = {}, -- footer
        }
        require("dashboard").setup({
            theme = "hyper",           --  theme is doom and hyper default is hyper
            disable_move = false,      --  default is false disable move keymap for hyper
            shortcut_type = "number",  --  shorcut type 'letter' or 'number'
            change_to_vcs_root = true, -- default is false,for open file in hyper mru. it will change to the root of vcs
            config = config,           --  config used for theme
            hide = {
                statusline = false,    -- hide statusline default is true
                tabline = false,       -- hide the tabline
                winbar = false,        -- hide winbar
            },
            -- preview = {
            --     command, -- preview command
            --     file_path  -- preview file path
            --     file_height -- preview file height
            --     file_width -- preview file width
            -- }
        })
    end,

    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
    },
}
