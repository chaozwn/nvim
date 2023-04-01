local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end

-- 判断具体系统
-- if vim.fn.has("wsl") == 1 and vim.fn.has("linux") == 1 then
-- elseif vim.fn.has('mac') == 1 then
-- end

local db_path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3"
if vim.fn.filereadable(db_path) == 0 then
  -- 如果数据库文件不存在，创建一个新的数据库文件
  local f = io.open(db_path, "w")
  f:close()
end

-- local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- vertical , center , cursor
    layout_strategy = "horizontal",
    -- 窗口内快捷键
    mappings = require("keybindings").telescopeList,
    vimgrep_arguments = {
      "rg", "--color=never", "--no-heading", "--with-filename",
      "--line-number", "--column", "--smart-case", "--trim",
      '--no-ignore', '--hidden'
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    sorting_strategy = "descending",
    file_ignore_patterns = {
      "^node_modules", "^.git", "build", ".cache", "%.class"
    },
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  },
  extensions = {
    project = {
      theme = "dropdown",
      hidden_files = true,
      -- order_by = "asc",
      base_dirs = {},
      mappings = {},
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case",the default case_mode is "smart_case"
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    },
  },
})

pcall(telescope.load_extension, "env")
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
pcall(telescope.load_extension, "ui-select")
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "asynctasks")
