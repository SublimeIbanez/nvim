-- Before plugins
require("config")
require("keymap")

-- Fuck you Neotree (Force close)
function Quit()
    vim.cmd("quit")
    local buffers = vim.api.nvim_list_bufs()
    local visibleBuffers = 0

    for _, buf in pairs(buffers) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and vim.bo[buf].filetype ~= "neo-tree" then
            visibleBuffers = visibleBuffers + 1
        end
    end

    if visibleBuffers == 0 then
        vim.cmd("Neotree close")
    else
        vim.cmd("quit")
    end
end
vim.keymap.set("n", "<leader>ee", Quit, { noremap = true, silent = true, desc = "Quit" })

-- Lazy Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}
require("lazy").setup("plugins", opts)



