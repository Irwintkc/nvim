-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function molten_is_ready()
  return vim.fn.exists(":MoltenInit") == 2 and vim.fn.exists("*MoltenStatusLineInit") == 1
end

vim.api.nvim_create_autocmd("BufEnter", {

  pattern = "*.py",

  callback = function(e)
    if string.match(e.file, ".otter.") then
      return
    end

    if molten_is_ready() then
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)

      vim.fn.MoltenUpdateOption("virt_text_output", false)
    else
      vim.g.molten_virt_lines_off_by_1 = false

      vim.g.molten_virt_text_output = false
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {

  pattern = { "*.qmd", "*.md", "*.ipynb" },

  callback = function(e)
    if string.match(e.file, ".otter.") then
      return
    end

    if molten_is_ready() then
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)

      vim.fn.MoltenUpdateOption("virt_text_output", true)
    else
      vim.g.molten_virt_lines_off_by_1 = true

      vim.g.molten_virt_text_output = true
    end
  end,
})

local imb = function(e)
  if vim.fn.exists(":MoltenInit") ~= 2 then
    return
  end

  vim.schedule(function()
    local kernels = vim.fn.MoltenAvailableKernels()

    local try_kernel_name = function()
      local file = io.open(e.file, "r")

      if not file then
        return nil
      end

      local content = file:read("a")

      file:close()

      local metadata = vim.json.decode(content)["metadata"]

      return metadata.kernelspec.name
    end

    local ok, kernel_name = pcall(try_kernel_name)

    if not ok or kernel_name == nil or not vim.tbl_contains(kernels, kernel_name) then
      kernel_name = nil

      local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")

      if venv ~= nil then
        kernel_name = string.match(venv, "/.+/(.+)")
      end
    end

    if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
      vim.cmd(("MoltenInit %s"):format(kernel_name))
    end

    if vim.fn.exists(":MoltenImportOutput") == 2 then
      vim.cmd("MoltenImportOutput")
    end
  end)
end

vim.api.nvim_create_autocmd("BufAdd", {

  pattern = { "*.ipynb" },

  callback = imb,
})

vim.api.nvim_create_autocmd("BufEnter", {

  pattern = { "*.ipynb" },

  callback = function(e)
    if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
      imb(e)
    end
  end,
})

local aug = vim.api.nvim_create_augroup("ImgClipMakeModifiable", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0) -- save cursor
    -- vim.cmd("normal! gg=G")
    vim.api.nvim_win_set_cursor(0, pos) -- restore cursor
  end,
})
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "BufEnter" }, {
  callback = function()
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#7aa2f7", bg = "NONE" })

    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#5fa8d3", bg = "NONE" })

    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#5fa8d3", bg = "NONE" })

    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true, bg = "NONE" })
  end,
})

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "LspAttach" }, {

  callback = function()
    vim.api.nvim_set_hl(0, "LspInlayHint", {

      fg = "#6e848f",

      bg = "#313244",

      italic = false,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {

  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
vim.api.nvim_set_hl(0, "@keyword.import.python", { fg = "#bb9af7", bold = true })

vim.api.nvim_set_hl(0, "@module.python", { fg = "#7dcfff" })

vim.api.nvim_set_hl(0, "@variable.python", { fg = "#c0caf5" })

vim.api.nvim_set_hl(0, "@function.python", { fg = "#7aa2f7" })

vim.api.nvim_set_hl(0, "@function.call.python", { fg = "#7aa2f7" })

vim.api.nvim_set_hl(0, "@parameter.python", { fg = "#ffb86c" })

vim.api.nvim_set_hl(0, "@string.python", { fg = "#9ece6a" })

vim.api.nvim_set_hl(0, "@comment.python", { fg = "#6c7086", italic = true })
