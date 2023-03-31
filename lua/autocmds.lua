local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- nvim-tree 自动关闭
autocmd("BufEnter", {
  nested = true,
  group = myAutoGroup,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd("quit")
    end
  end,
})

local system = vim.loop.os_uname().sysname

if system == 'Linux' then

elseif system == 'Darwin' then 
  -- 自动切换输入法，需要安装 im-select
  -- https://github.com/daipeihust/im-select
  autocmd("InsertLeave", {
  group = myAutoGroup,
  callback = require("utils.im-select").macInsertLeave,
  })
  autocmd("InsertEnter", {
    group = myAutoGroup,
  callback = require("utils.im-select").macInsertEnter,
  })
  -- 当vim获得焦点和失去焦点的时候触发
  autocmd("FocusGained", {
  group = myAutoGroup,
  callback = require("utils.im-select").macFocusGained,
  })
  autocmd("FocusLost", {
    group = myAutoGroup,
    callback = require("utils.im-select").macFocusLost,
  })
elseif system == "Windows" then 

end

-- 修改lua/plugins.lua 自动更新插件
-- autocmd("BufWritePost", {
--   group = myAutoGroup,
--   -- autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   callback = function()
--     if vim.fn.expand("<afile>") == "lua/plugins.lua" then
--       vim.api.nvim_command("source lua/plugins.lua")
--       vim.api.nvim_command("PackerSync")
--     end
--   end,
-- })


-- 进入Terminal 自动进入插入模式
autocmd("TermOpen", {
  group = myAutoGroup,
  command = "startinsert",
})

-- 高亮复制的文字
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = myAutoGroup,
  pattern = "*",
})

-- 用o换行不要延续注释
autocmd("BufEnter", {
  group = myAutoGroup,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
      - "o" -- O and o, don't continue comments
      + "r" -- But do continue when pressing enter.
  end,
})

-- 重新打开缓冲区恢复光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.fn.setpos(".", vim.fn.getpos("'\""))
			vim.cmd("silent! foldopen")
		end
	end,
})
