return {

  {

    "benlubas/molten-nvim",

    version = "^1.0.0",

    build = ":UpdateRemotePlugins",

    lazy = false,

    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_cell_delimiters = { "# %%", "#%%" }
      vim.g.molten_output_win_max_height = 20
    end,

    config = function()
      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", {

        silent = true,

        desc = "Initialize the plugin",
      })

      vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", {

        silent = true,

        desc = "Run operator selection",
      })

      vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", {

        silent = true,

        desc = "Evaluate line",
      })

      vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", {

        silent = true,

        desc = "Re-evaluate cell",
      })

      vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", {

        silent = true,

        desc = "Evaluate visual selection",
      })

      vim.keymap.set("n", "<localleader>rd", ":MoltenDelete<CR>", {

        silent = true,

        desc = "Molten delete cell",
      })

      vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", {

        silent = true,

        desc = "Hide output",
      })

      vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", {

        silent = true,

        desc = "Show/enter output",
      })
    end,
  },
}
