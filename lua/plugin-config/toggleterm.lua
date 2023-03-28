---@diagnostic disable: missing-parameter
local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("没有找到 toggleterm")
  return
end

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
  start_in_insert = true,
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    -- q / <leader>tg 关闭 terminal
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<leader>tg", "<cmd>close<CR>", { noremap = true, silent = true })
    -- ESC 键取消，留给lazygit
    if vim.fn.mapcheck("<Esc>", "t") ~= "" then
      vim.api.nvim_del_keymap("t", "<Esc>")
    end
  end,
  on_close = function(_)
    -- 添加回来
    vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {
      noremap = true,
      silent = true,
    })
  end,
})

local float = Terminal:new({
  direction = "float",
  close_on_exit = true,
})

local vertical = Terminal:new({
  direction = "vertical",
  close_on_exit = true,
})

local horizontal = Terminal:new({
  direction = "horizontal",
  close_on_exit = true,
})

local M = {}

M.toggleFloat = function()
  if float:is_open() then
    float:close()
    return
  end
  vertical:close()
  horizontal:close()
  float:open()
end

M.toggleVertical = function()
  if vertical:is_open() then
    vertical:close()
    return
  end
  float:close()
  horizontal:close()
  vertical:open()
end

M.toggleHorizontal = function()
  if horizontal:is_open() then
    horizontal:close()
    return
  end
  float:close()
  vertical:close()
  horizontal:open()
end

M.toggleGit = function()
  lazygit:toggle()
end

require("keybindings").mapToggleTerm(M)
