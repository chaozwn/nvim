local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("没有找到 nvim-treesitter")
  return
end

local rainbow = { "#CC8888", "#CCCC88", "#88CC88", "#88CCCC", "#8888CC", "#CC88CC" }
-- :TSModuleInfo 查看已经开启的模块
treesitter.setup({
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx", "python", "java" },
  sync_intsall = true,
  -- ensure_installed = "maintained",

  -- 启用代码高亮模块
  highlight = {
    enable = true,
    -- 大文件关闭高亮
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
    additional_vim_regex_highlighting = false,
  },
  -- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  -- 启用代码缩进模块, 启用这个功能后visual模式下对代码进行选中按(=)可以格式化代码, gg=G: 返回文件首行，相当于对所有代码进行格式化
  -- 这边我们使用coc的代码格式化
  indent = {
    enable = false,
    disable = {}
  },
  autotag = {
    enable = true
  },
  context_commentstring =  {
    enable = true
  },
  yati = {
			enable = true,
			disable = {},
			default_lazy = true,
			default_fallback = "asis"
  },
  -- p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = rainbow,
    termcolors = rainbow
    -- colors = {
    --   "#95ca60",
    --   "#ee6985",
    --   "#D6A760",
    --   "#7794f4",
    --   "#b38bf5",
    --   "#7cc7fe",
    -- }, -- table of hex strings
    -- termcolors = { } -- table of colour name strings
  },
})
-- 开启 Folding 模块, 使用zc折叠代码，zo打开折叠代码
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99


local status, treesitter_context = pcall(require, "treesitter-context")
if not status then
  vim.notify("没有找到 treesitter_context")
  return
end

treesitter_context.setup({
	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
	trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
		-- For all filetypes
		-- Note that setting an entry here replaces all other patterns for this entry.
		-- By setting the 'default' entry below, you can control which nodes you want to
		-- appear in the context window.
		default = {
			'class',
			'function',
			'method',
			'for',
			'while',
			'if',
			'switch',
			'case',
		},
		-- Patterns for specific filetypes
		-- If a pattern is missing, *open a PR* so everyone can benefit.
		tex = {
			'chapter',
			'section',
			'subsection',
			'subsubsection',
		},
		rust = {
			'impl_item',
			'struct',
			'enum',
		},
		scala = {
			'object_definition',
		},
		vhdl = {
			'process_statement',
			'architecture_body',
			'entity_declaration',
		},
		markdown = {
			'section',
		},
		elixir = {
			'anonymous_function',
			'arguments',
			'block',
			'do_block',
			'list',
			'map',
			'tuple',
			'quoted_content',
		},
		json = {
			'pair',
		},
		yaml = {
			'block_mapping_pair',
		},
	},
	exact_patterns = {
		-- Example for a specific filetype with Lua patterns
    -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
    -- exactly match "impl_item" only)
		-- rust = true,
	},

	-- [!] The options below are exposed but shouldn't require your attention,
	--     you can safely ignore them.

	zindex = 20, -- The Z-index of the context window
	mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
})

for i, c in ipairs(rainbow) do -- p00f/rainbow#81
	vim.cmd(("hi rainbowcol%d guifg=%s"):format(i, c))
end

