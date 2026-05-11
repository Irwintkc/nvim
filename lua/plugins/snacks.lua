return {

  {

    "folke/snacks.nvim",

    keys = {

      {

        "<leader>ft",

        function()
          Snacks.terminal(nil, {

            cwd = LazyVim.root(),

            win = {

              position = "right",

              width = 110,
            },
          })
        end,

        desc = "Terminal Right",
      },
    },
  },
}
