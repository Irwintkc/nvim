return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },

        lua = { "stylua" },

        cpp = { "clang_format" },
        c = { "clang_format" },

        sh = { "shfmt" },
      },
    },
  },
}
