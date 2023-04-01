local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

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

-- nvim-tree 自动关闭
local function tab_win_closed(winnr)
  local api = require "nvim-tree.api"
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then        -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else                                                    -- else closed buffer was normal buffer
    if #tab_bufs == 1 then                                -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
        vim.schedule(function()
          if #vim.api.nvim_list_wins() == 1 then          -- if its the last buffer in vim
            vim.cmd "quit"                                -- then close all of vim
          else                                            -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true)     -- then close only the tab
          end
        end)
      end
    end
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true
})
