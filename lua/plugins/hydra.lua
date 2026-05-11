return {
  "nvimtools/hydra.nvim",
  config = function()
    -- create hydras in here
  end,

  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup()
    end,
  },
}
