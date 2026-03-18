return {
  -- Gruvbox theme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false, -- load immediately
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "soft", -- can be "soft", "medium", or "hard"
        dim_inactive = true, -- dim inactive windows
        transparent_mode = false,
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
