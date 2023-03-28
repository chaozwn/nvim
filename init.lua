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
