-- https://github.com/nvim-neo-tree/neo-tree.nvim 
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            filesystem = {
                bind_to_cwd = true,
            },
            hijack_netrw_behavior = "open_default",
            window = {
                position = "right",
            },
        })
    end
}

