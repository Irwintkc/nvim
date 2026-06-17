return {
  {

    "hrsh7th/nvim-cmp",

    opts = function(_, opts)
      local cmp = require("cmp")

      local luasnip = require("luasnip")

      opts.completion = {

        completeopt = "menu,menuone,noinsert,noselect",
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {

        ["<CR>"] = cmp.mapping(function(fallback)
          fallback()
        end, { "i", "s" }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = [[
██╗    ██╗██╗███╗   ██╗████████╗██╗  ██╗ ██████╗
██║    ██║██║████╗  ██║╚══██╔══╝██║ ██╔╝██╔════╝
██║ █╗ ██║██║██╔██╗ ██║   ██║   █████╔╝ ██║     
██║███╗██║██║██║╚██╗██║   ██║   ██╔═██╗ ██║     
╚███╔███╔╝██║██║ ╚████║   ██║   ██║  ██╗╚██████╗
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝
 ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
        sections = {
          { section = "header" },
          {
            section = "terminal",
            cmd = "img2art ~/.config/nvim/planet.jpg --threshold 10 --scale .0275 --quant 32 --with-color ",
            height = 18,
            width = 75,
          },
          { section = "keys" },
          { section = "startup" },
        },
      },

      image = {
        enabled = true,
      },
    },
  },
}
