-- 基础配置文件
require('basic')
-- 快捷键映射
require('keybindings')
-- Packer插件管理
require('plugins')
-- 主题设置
require('colorscheme')
-- 自动命令
require('autocmds')



-- 插件配置
-- 文件树
require("plugin-config.nvim-tree")
-- Tabs标签
require("plugin-config.bufferline")
-- lualine配置,下方状态栏
require("plugin-config.lualine")
-- telescope快速搜索插件
require("plugin-config.telescope")

-- 引入dashboard，同时关联project
require("plugin-config.dashboard")
require("plugin-config.project")

-- 引入代码高亮
require('plugin-config.nvim-treesitter')

-- 缩进美化
require("plugin-config.indent-blankline")

-- 引入代码注释插件
require('plugin-config.comment')

-- 包含符号快速替换
require("plugin-config.surround")

-- 括号自动补全
require("plugin-config.nvim-autopairs")

-- 终端插件
require("plugin-config.toggleterm")

-- 自动保存插件
-- require("plugin-config.autosave")

-- 替换和交换插件
require("plugin-config.substitute")

-- leap瞬间移动插件
require("plugin-config.leap")
-- flit，f,t加强插件
require('plugin-config.flit')

-- coc插件
require("plugin-config.coc")

-- todo-comment插件
require("plugin-config.todo-comments")
