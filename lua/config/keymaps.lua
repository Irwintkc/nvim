-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")
local nmap = function(key, effect, desc)
  vim.keymap.set("n", key, effect, { silent = true, noremap = true, desc = desc })
end

local vmap = function(key, effect, desc)
  vim.keymap.set("v", key, effect, { silent = true, noremap = true, desc = desc })
end

local imap = function(key, effect, desc)
  vim.keymap.set("i", key, effect, { silent = true, noremap = true, desc = desc })
end

local cmap = function(key, effect, desc)
  vim.keymap.set("c", key, effect, { silent = true, noremap = true, desc = desc })
end
vim.api.nvim_set_keymap("i", "<C-e>", "<End>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "jj", " <Esc>", { noremap = true, silent = true })
-- send code with ctrl+Enter
-- just like in e.g. RStudio
-- needs kitty (or other terminal) config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
local function send_cell()
  local has_molten, molten_status = pcall(require, "molten.status")
  local molten_works = false
  local molten_active = ""
  if has_molten then
    molten_works, molten_active = pcall(molten_status.kernels)
  end
  if molten_works and molten_active ~= vim.NIL and molten_active ~= "" then
    molten_active = molten_status.initialized()
  end
  if molten_active ~= vim.NIL and molten_active ~= "" and molten_status.kernels() ~= "Molten" then
    vim.cmd.QuartoSend()
    return
  end

  if vim.b["quarto_is_r_mode"] == nil then
    vim.fn["slime#send_cell"]()
    return
  end
  if vim.b["quarto_is_r_mode"] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require("otter.tools.functions").is_otter_language_context("python")
    if is_python and not vim.b["reticulate_running"] then
      vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
      vim.b["reticulate_running"] = true
    end
    if not is_python and vim.b["reticulate_running"] then
      vim.fn["slime#send"]("exit" .. "\r")
      vim.b["reticulate_running"] = false
    end
    vim.fn["slime#send_cell"]()
  end
end
nmap("<c-cr>", send_cell)
nmap("<s-cr>", send_cell)
imap("<c-cr>", send_cell)
imap("<s-cr>", send_cell)
local is_code_chunk = function()
  local current, _ = require("otter.keeper").get_current_language_context()
  if current then
    return true
  else
    return false
  end
end
local insert_code_chunk = function(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

local insert_r_chunk = function()
  insert_code_chunk("r")
end

local insert_py_chunk = function()
  insert_code_chunk("python")
end
vim.keymap.set("n", "<M-i>", insert_py_chunk, {
  silent = true,
  noremap = true,
  desc = "Insert Python code chunk",
})

-- Insert an R chunk with Alt‑Shift‑i
vim.keymap.set("n", "<M-I>", insert_r_chunk, {
  silent = true,
  noremap = true,
  desc = "Insert R code chunk",
})
