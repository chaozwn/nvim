-- n Normal 模式
-- i Insert 模式
-- v Visual 模式
-- t Terminal 模式
-- c Command 模式
-- 普通模式 (normal mode)
-- 移动光标、切换模式都是在普通模式下进行的
-- 插入模式 (insert mode)
-- 插入模式主要用来编辑文本，在该模式下可以进行文本的编辑操作
-- 可视模式(visual mode)
-- 该模式主要用来选择一部分文本，实现的功能跟用鼠标选中一段文本一样
-- 命令行模式(command mode)
-- 可以在普通模式和可视模式下输入:, 进入命令行模式

-- 设置leader key为空字符串
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 设置option常量
local opt = {
  noremap = true,
  silent = true,
}

-- 设置本地变量
local map = vim.api.nvim_set_keymap

-- $跳到行尾不带空格(交换$和g_)       
map('v', '$', 'g_', opt)
map('v', 'g_', '$', opt)
map('n', '$', 'g_', opt)
map('n', 'g_', '$', opt)

-- 命令行下 Ctrl + j/k 上一个下一个
map('c', '<C-j>', '<C-n>', { noremap = false })
map('c', '<C-k>', '<C-p>', { noremap = false })

-- 保存文件
map('n', '<leader>w', ':w<CR>', opt)
map('n', '<leader>wq', ':wqa!<CR>', opt)

-- 退出
-- map("n", "qq", ":q!<CR>", opt)
map("n", "<leader>q", ":qa!<CR>", opt)

-- 当一行过长的时候jk移动可以被gj和gk代替
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 上下滚动浏览
map('n', '<C-j>', '5j', opt)
map('n', '<C-k>', '5k', opt)
map('v', '<C-j>', '5j', opt)
map('v', '<C-k>', '5k', opt)

-- ctrl u/d 上下移动9行，默认ctrl u/d是移动半屏
map('n', '<C-u>', '10k', opt)
map('n', '<C-d>', '10j', opt)

-- 开启魔术搜索,即可以通过正则来搜索 
map("n", "/", "/\\v", { noremap = true, silent = false })
map("v", "/", "/\\v", { noremap = true, silent = false })

-- visual模式下缩进代码, 缩进后仍然可以继续选中区域
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)

-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 在visual mode 里粘贴不要复制
map("v", "p", '"_dP', opt)

-- insert模式下,跳到行首行尾,不建议使用
-- map("i", "<C-h>", "<ESC>I", opt)
-- map("i", "<C-l>", "<ESC>A", opt)


-----------------------------------------------------------------------------------------
-- 分屏快捷键
-----------------------------------------------------------------------------------------
-- 取消 s 默认功能
map('n', 's', '', opt)
map('n', 'sv', ':vsp<CR>', opt)
map('n', 'sh', ':sp<CR>', opt)

-- 关闭当前
map('n', 'sc', '<C-w>c', opt)
-- 关闭其他
map('n', 'so', '<C-w>o', opt)

-- alt + hjkl  窗口之间跳转, win中生效
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- <leader> + hjkl 窗口之间跳转
map("n", "<leader>h", "<C-w>h", opt)
map("n", "<leader>j", "<C-w>j", opt)
map("n", "<leader>k", "<C-w>k", opt)
map("n", "<leader>l", "<C-w>l", opt)

-- 左右比例控制
-- map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
-- map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -10<CR>", opt)
map("n", "s.", ":vertical resize +10<CR>", opt)
-- 上下比例
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
-- map("n", "<C-Down>", ":resize +2<CR>", opt)
-- map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 相等比例
map("n", "s=", "<C-w>=", opt)

-- Terminal相关
map("n", "st", ":sp | terminal<CR>", opt)
map("n", "stv", ":vsp | terminal<CR>", opt)

-- Esc 回 Normal 模式 ?? 目前不生效
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
map("t", "<leader>h", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<leader>j", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<leader>k", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<leader>l", [[ <C-\><C-N><C-w>l ]], opt)

-------------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------------
local pluginKeys = {}

-- 文件浏览树相关配置
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>m", ":NvimTreeToggle<CR>", opt)
pluginKeys.nvimTreeList = { -- 打开文件或文件夹
  { key = { "o", "<2-LeftMouse>" }, action = "edit" },
  { key = "<CR>", action = "system_open" },
  -- v分屏打开文件
  { key = "v", action = "vsplit" },
  -- h分屏打开文件
  { key = "h", action = "split" },
  -- Ignore (node_modules)
  { key = "i", action = "toggle_ignored" },
  -- Hide (dotfiles)
  { key = ".", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },
  -- 文件操作
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "y", action = "copy_name" },
  { key = "Y", action = "copy_path" },
  { key = "gy", action = "copy_absolute_path" },
  { key = "I", action = "toggle_file_info" },
  { key = "n", action = "tabnew" },
  -- 进入下一级
  { key = { "]" }, action = "cd" },
  -- 进入上一级
  { key = { "[" }, action = "dir_up" },
}

-- bufferline, Tabs标签页相关配置
-- 左右Tab切换
-- map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
-- map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
map("n", "<C-S-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-S-l>", ":BufferLineCycleNext<CR>", opt)
-- "moll/vim-bbye" 关闭当前 buffer
map("n", "<leader>bc", ":Bdelete!<CR>", opt)
map("n", "<C-w>", ":Bdelete!<CR>", opt)
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)
-- 关闭选中标签页
map("n", "<leader>bp", ":BufferLinePickClose<CR>", opt)

-- Telescope,即搜索窗功能
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<C-n>"] = "move_selection_next",
    ["<C-p>"] = "move_selection_previous",
    -- 历史记录
    ["<Down>"] = "cycle_history_next",
    ["<Up>"] = "cycle_history_prev",
    -- 关闭窗口
    -- ["<esc>"] = actions.close,
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}


-- 代码注释插件
-- see ./lua/plugin-config/comment.lua
-- 禁用item2的find cursor
-- defaults write com.googlecode.iterm2 NSUserKeyEquivalents -dict-add "Find Cursor" nil
pluginKeys.comment = {
  -- Normal 模式快捷键
  toggler = {
    line = "gcc", -- 行注释
    block = "gbc", -- 块注释
  },
  -- Visual 模式
  opleader = {
    line = "gc",
    bock = "gb",
  },
}
-- ctrl + / 替换原来的gcc
map("n", "<C-/>", "gcc", { noremap = false })
map("v", "<C-/>", "gcc", { noremap = false })

-- 自定义 toggleterm 3个不同类型的命令行窗口
-- <leader>ta 浮动
-- <leader>tb 右侧
-- <leader>tc 下方
-- 特殊lazygit 窗口，需要安装lazygit
-- <leader>tg lazygit
pluginKeys.mapToggleTerm = function(toggleterm)
  vim.keymap.set({ "n", "t" }, "<leader>ta", toggleterm.toggleA)
  vim.keymap.set({ "n", "t" }, "<leader>tb", toggleterm.toggleB)
  vim.keymap.set({ "n", "t" }, "<leader>tc", toggleterm.toggleC)
  vim.keymap.set({ "n", "t" }, "<leader>tg", toggleterm.toggleG)
end

return pluginKeys
