return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = {
        "bash",
        "c",
        "lua",
        "python",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
      }

      opts.highlight = { enable = true }
      opts.auto_install = false

      opts.install = opts.install or {}
      opts.install.compilers = { "gcc", "cc" }
      opts.install.prefer_git = true
    end,
  },
}
