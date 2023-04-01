-- n Normal 模式
-- v Visual 模式
-- t Terminal 模式 c Command 模式 普通模式 (normal mode)
-- 移动光标、切换模式都是在普通模式下进行的
-- 插入模式 (insert mode)
-- 插入模式主要用来编辑文本，在该模式下可以进行文本的编辑操作
-- 可视模式(visual mode)
-- 该模式主要用来选择一部分文本，实现的功能跟用鼠标选中一段文本一样
-- 命令行模式(command mode)
-- 可以在普通模式和可视模式下输入:, 进入命令行模式
local G = require('G')

local system = vim.loop.os_uname().sysname
-- 设置leader key为空字符串
G.g.mapleader = ' '
G.g.maplocalleader = ' '

-- 设置option常量
local opt = {
  noremap = true,
  silent = true,
}

-- $跳到行尾不带空格(交换$和g_)
G.map({
  { 'v', '$',  'g_', opt },
  { 'v', 'g_', '$',  opt },
  { 'n', '$',  'g_', opt },
  { 'n', 'g_', '$',  opt },
})

-- 命令行下 Ctrl + j/k 上一个下一个
G.map({
  { 'c', '<C-j>', '<C-n>', { noremap = false } },
  { 'c', '<C-k>', '<C-p>', { noremap = false } },
})

-- 保存文件
G.map({
  { 'n', '<leader>w',  ':w<CR>',    opt },
  { 'n', '<leader>wq', ':wqa!<CR>', opt }
})

-- 退出
-- map("n", "qq", ":q!<CR>", opt)
G.map({
  { "n", "<leader>q", ":qa!<CR>", opt }
})

-- 当一行过长的时候jk移动可以被gj和gk代替
G.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
G.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 上下滚动浏览
G.map({
  { 'n', '<C-j>', '5j', opt },
  { 'n', '<C-k>', '5k', opt },
  { 'v', '<C-j>', '5j', opt },
  { 'v', '<C-k>', '5k', opt },
})

-- ctrl u/d 上下移动9行，默认ctrl u/d是移动半屏
G.map({
  { 'n', '<C-u>', '10k', opt },
  { 'n', '<C-d>', '10j', opt },
})

-- 开启魔术搜索,即可以通过正则来搜索
G.map({
  { "n", "/", "/\\v", { noremap = true, silent = false } },
  { "v", "/", "/\\v", { noremap = true, silent = false } },
})

-- visual模式下缩进代码, 缩进后仍然可以继续选中区域
G.map({
  { 'v', '<', '<gv', opt },
  { 'v', '>', '>gv', opt },
})

-- 上下移动选中文本
G.map({
  { "v", "J", ":move '>+1<CR>gv-gv", opt },
  { "v", "K", ":move '<-2<CR>gv-gv", opt },
})

-- 在visual mode 里粘贴不要复制
G.map({
  { "v", "p", '"_dP', opt },
})

-- insert模式下,跳到行首行尾,不建议使用
-- map("i", "<C-h>", "<ESC>I", opt)
-- map("i", "<C-l>", "<ESC>A", opt)

-----------------------------------------------------------------------------------------
-- 分屏快捷键
-----------------------------------------------------------------------------------------
G.map({
  -- 取消 s 默认功能
  { 'n', 's',         '',                         opt },
  { 'n', 'sv',        ':vsp<CR>',                 opt },
  { 'n', 'sh',        ':sp<CR>',                  opt },
  -- 关闭当前
  { 'n', 'sc',        '<C-w>c',                   opt },
  -- 关闭其他
  { 'n', 'so',        '<C-w>o',                   opt },
  -- alt + hjkl  窗口之间跳转, win中生效
  { "n", "<A-h>",     "<C-w>h",                   opt },
  { "n", "<A-j>",     "<C-w>j",                   opt },
  { "n", "<A-k>",     "<C-w>k",                   opt },
  { "n", "<A-l>",     "<C-w>l",                   opt },
  -- <leader> +jhjkl 窗口之间跳转
  -- { "n", "<tab>h",    "<C-w>h",                   opt },
  -- { "n", "<tab>j",    "<C-w>j",                   opt },
  -- { "n", "<tab>k",    "<C-w>k",                   opt },
  -- { "n", "<tab>l",    "<C-w>l",                   opt },
  -- 左右比例控制
  { "n", "<C-Left>",  ":vertical resize -2<CR>",  opt },
  { "n", "<C-Right>", ":vertical resize +2<CR>",  opt },
  { "n", "s,",        ":vertical resize -10<CR>", opt },
  { "n", "s.",        ":vertical resize +10<CR>", opt },
  -- 上下比例
  { "n", "sj",        ":resize +10<CR>",          opt },
  { "n", "sk",        ":resize -10<CR>",          opt },
  { "n", "<C-Down>",  ":resize +2<CR>",           opt },
  { "n", "<C-Up>",    ":resize -2<CR>",           opt },
  -- 相等比例
  { "n", "s=",        "<C-w>=",                   opt },
})


-- 关闭搜索高亮
G.map({
  { 'n', '<leader>nh', ':nohlsearch<CR>', opt },
})

-- Terminal相关
-- map("n", "st", ":sp | terminal<CR>", opt)
-- map("n", "stv", ":vsp | terminal<CR>", opt)

-- Esc 回 Normal 模式 ?? 目前不生效
-- map("t", "<Esc>", "<C-\\><C-n>", opt)
-- map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
-- map("t", "<leader>h", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<leader>j", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<leader>k", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<leader>l", [[ <C-\><C-N><C-w>l ]], opt)

-------------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------------
local pluginKeys = {}

-- 文件浏览树相关配置
G.map({
  { "n", "<A-m>",      ":NvimTreeToggle<CR>",   opt },
  { "n", "<leader>te", ":NvimTreeFocus<CR>",    opt },
  { "n", "<leader>tc", ":NvimTreeClose<CR>",    opt },
  -- 在文件树中打开文件
  { "n", "<leader>to", ":NvimTreeFindFile<CR>", opt },
})
pluginKeys.nvimTreeList = { -- 打开文件或文件夹
  { key = { "o", "<2-LeftMouse>" }, action = "edit" },
  { key = "<CR>",                   action = "system_open" },
  -- v分屏打开文件
  { key = "v",                      action = "vsplit" },
  -- h分屏打开文件
  { key = "h",                      action = "split" },
  -- Ignore (node_modules)
  { key = "i",                      action = "toggle_ignored" },
  -- Hide (dotfiles)
  { key = ".",                      action = "toggle_dotfiles" },
  { key = "R",                      action = "refresh" },
  -- 文件操作
  { key = "a",                      action = "create" },
  { key = "d",                      action = "remove" },
  { key = "r",                      action = "rename" },
  { key = "x",                      action = "cut" },
  { key = "c",                      action = "copy" },
  { key = "p",                      action = "paste" },
  { key = "y",                      action = "copy_name" },
  { key = "Y",                      action = "copy_path" },
  { key = "gy",                     action = "copy_absolute_path" },
  { key = "I",                      action = "toggle_file_info" },
  { key = "n",                      action = "tabnew" },
  -- 进入下一级
  { key = { "]" },                  action = "cd" },
  -- 进入上一级
  { key = { "[" },                  action = "dir_up" },
}

-- bufferline, Tabs标签页相关配置
if system == 'Darwin' then
  G.map({
    -- 左右Tab切换
    { "n", "<S-tab>", ":BufferLineCyclePrev<CR>", opt },
    { "n", "<tab>",   ":BufferLineCycleNext<CR>", opt },
  })
elseif system == 'window' then
  G.map({
    -- 左右Tab切换
    { "n", "<C-H>", ":BufferLineCyclePrev<CR>", opt },
    { "n", "<C-L>", ":BufferLineCycleNext<CR>", opt },
  })
end

G.map({
  -- "moll/vim-bbye" 关闭当前 buffer
  { "n", "<leader>bc", ":Bdelete!<CR>",                                     opt },
  { "n", "<C-w>",      ":Bdelete!<CR>",                                     opt },
  -- 关闭左/右侧标签页
  { "n", "<leader>bh", ":BufferLineCloseLeft<CR>",                          opt },
  { "n", "<leader>bl", ":BufferLineCloseRight<CR>",                         opt },
  -- 关闭其他标签页
  { "n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt },
  -- 关闭选中标签页
  { "n", "<leader>bp", ":BufferLinePickClose<CR>",                          opt },
  -- Telescope,即搜索窗功能
  { "n", "<C-p>",      ":Telescope find_files<CR>",                         opt },
  { "n", "<C-f>",      ":Telescope live_grep<CR>",                          opt },
})

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
    line = "gcc",  -- 行注释
    block = "gbc", -- 块注释
  },
  -- Visual 模式
  opleader = {
    line = "gc",
    bock = "gb",
  },
}


if system == 'Darwin' then
  -- ctrl + / 替换原来的gcc
  G.map({
    { "n", "<C-/>", "gcc", { noremap = false } },
    { "v", "<C-/>", "gcc", { noremap = false } },
  })
elseif system == 'window' then
  -- ctrl + / 替换原来的gcc
  G.map({
    { "n", "<C-_>", "gcc", { noremap = false } },
    { "v", "<C-_>", "gcc", { noremap = false } },
  })
end

-- 自定义 toggleterm 3个不同类型的命令行窗口
-- <leader>ta 浮动
-- <leader>tb 右侧
-- <leader>tc 下方
-- 特殊lazygit 窗口，需要安装lazygit
-- <leader>tg lazygit
pluginKeys.mapToggleTerm = function(toggleterm)
  G.keymap.set({ "n", "t" }, "<leader>tf", toggleterm.toggleFloat)
  G.keymap.set({ "n", "t" }, "<leader>tv", toggleterm.toggleVertical)
  G.keymap.set({ "n", "t" }, "<leader>th", toggleterm.toggleHorizontal)
  G.keymap.set({ "n", "t" }, "<leader>tg", toggleterm.toggleGit)
end

-- vim-visual-multi, 多光标插件
-- 按住ctrl + n选中，然后按n/N移动，q可以跳过当前选中项目
G.g.VM_maps = {
  ['Find Under'] = '<C-n>',
  ['Find Subword Under'] = '<C-n>',
}
if system == 'Darwin' then
  G.g.VM_maps = {
    ['Add Cursor Up'] = '<C-S-k>',
    ['Add Cursor Down'] = '<C-S-j>',
    ['Select All'] = '<C-S-n>'
  }
elseif system == 'window' then
  G.g.VM_maps = {
    ['Add Cursor Up'] = '<C-K>',
    ['Add Cursor Down'] = '<C-J>',
    ['Select All'] = '<C-N>'
  }
end

-- substitute, 交换和替换插件, 寄存器中的值，将会替换到s位置, s{motion}
pluginKeys.mapSubstitute = function(substitute)
  G.keymap.set("n", "s", substitute.operator, { noremap = true })
  G.keymap.set("n", "ss", substitute.line, { noremap = true })
  G.keymap.set("n", "S", substitute.eol, { noremap = true })
  -- 这个和surround插件冲突，所以不使用
  -- vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })

  -- substitute range, 开启范围性替换，<leader>s{motion}
  -- vim.keymap.set("n", "<leader>s", require('substitute.range').operator, { noremap = true })
  -- vim.keymap.set("x", "<leader>s", require('substitute.range').visual, { noremap = true })
  -- 直接对单词生效
  -- vim.keymap.set("n", "<leader>ss", require('substitute.range').word, { noremap = true })
end

pluginKeys.mapSubstituteExchange = function(exchange)
  -- substitute exchange, sx{motion} -> 移动到另外一个单词 sx{motion}
  G.keymap.set("n", "sx", exchange.operator, { noremap = true })
  G.keymap.set("n", "sxx", exchange.line, { noremap = true })
  G.keymap.set("x", "X", exchange.visual, { noremap = true })
  G.keymap.set("n", "sxc", exchange.cancel, { noremap = true })
end

-- leap瞬间移动插件
-- 使用指南
-- s + xx(two key pattern) + label
-- 自动跳转到第一个
-- 如果想要跳转到一行的最后一个位置，用<space>补齐
-- 多组跳转使用<space>和<tab>进行上下移动
-- 跳转到下一个搜索单词s<enter>
-- 默认是使用s和S进行搜索
-- 窗口跳转搜索gs
-- 可以和d,y,v,c一起使用
G.keymap.set({ "x", "o", "n" }, ";", "<Plug>(leap-forward-to)")
G.keymap.set({ "x", "o", "n" }, ",", "<Plug>(leap-backward-to)")
G.keymap.set({ "x", "o", "n" }, "<leader>s", "<Plug>(leap-from-window)")

-- todo comments
pluginKeys.todoComments = function(todo_comments)
  G.keymap.set("n", "]t", function()
    todo_comments.jump_next()
  end)
  G.keymap.set("n", "[t", function()
    todo_comments.jump_prev()
  end)
end
-- Telescope,即搜索窗功能
G.map({
  { "n", "<leader>lc", ":TodoTelescope keywords=TODO,FIX,HACK,WARN,PERF,NOTE,TEST <CR>", opt },
  -- 指定搜索文件夹, :TodoTrouble cwd=~/projects/foobar
})

return pluginKeys
