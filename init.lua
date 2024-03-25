require("config")
require("keymap")

-- vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
--     pattern = "*",
--     callback = function()
--         if vim.bo.filetype == "neo-tree" then
--             vim.wo.number = false
--             vim.wo.relativenumber = false
--             vim.wo.signcolumn = "no"
--         end
--     end
-- })

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

-- VimEnter
-- vim.api.nvim_create_autocmd("VimEnter", {
--     pattern = "",
--     callback = function()
--         if vim.fn.bufname() == "" then
--             -- Dashboard must be loaded before neotree
--             vim.cmd("Dashboard")
--         end
--     end,
-- })
-- vim.api.nvim_create_autocmd("WinEnter", {
--     pattern = "*",
--     callback = function()
--         vim.cmd("Neotree show")
--     end
-- })
