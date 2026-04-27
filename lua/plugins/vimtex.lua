return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_compiler_method = "latexmk"

      -- Tell VimTeX that we want the lualatex engine
      vim.g.vimtex_compiler_engine = "lualatex"

      -- Map this engine to the proper latexmk option
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-lualatex", -- default engine for all projects
      }
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_view_sioyek_exe = "/Applications/sioyek.app/Contents/MacOS/sioyek"
    end,
  },
}
