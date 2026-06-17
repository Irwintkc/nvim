-- ~/.config/nvim/lua/plugins/luasnip.lua
return {
  {
    "L3MON4D3/LuaSnip",
    opts = {
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    },
    config = function(_, opts)
      local ls = require("luasnip")
      ls.config.setup(opts)

      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
      })
    end,
  },
}
