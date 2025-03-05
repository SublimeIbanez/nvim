return {
  -- Surround
  {
    -- Adds `s` to surround the current actions
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",

    config = function()
      require("nvim-surround").setup({})
    end,
  },
}
