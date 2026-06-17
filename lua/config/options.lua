-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.sidescrolloff = 0
vim.opt.sidescroll = 0
vim.opt.relativenumber = false
vim.env.PATH = "/home/i/ikhaiche/.local/bin:" .. vim.env.PATH
-- Add any additional options here
vim.env.PATH = vim.env.HOME .. "/bin:" .. vim.env.PATH
vim.g.python3_host_prog = "/opt/homebrew/Caskroom/miniforge/base/envs/herd/bin/python"
vim.env.PATH = "/opt/homebrew/Caskroom/miniforge/base/envs/herd/bin:" .. vim.env.PATH
vim.api.nvim_set_hl(0, "LspInlayHint", {
  fg = "#cdd6f4", -- brighter text
  bg = "#313244", -- darker background
  italic = false,
})
