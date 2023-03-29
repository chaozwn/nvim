local M = {}

-- 使用这个autocmd的条件是使用mac输入法
M.sougouIM = "com.sogou.inputmethod.sogou.pinyin"
M.defaultIM = "com.apple.keylayout.ABC"
M.leaveVimIM = M.defaultIM

M.macFocusGained = function() 
  vim.cmd(":silent :!im-select" .. " " .. M.leaveVimIM)
end

M.macFocusLost = function()
  M.leaveVimIM = vim.fn.system({ "im-select" })
  vim.cmd(":silent :!im-select" .. " " .. M.sougouIM)
end

M.macInsertLeave = function()
  vim.cmd(":silent :!im-select" .. " " .. M.defaultIM)
end

M.macInsertEnter = function()
  vim.cmd(":silent :!im-select" .. " " .. M.sougouIM)
end

M.windowsInsertLeave = function()
  vim.cmd(":silent :!~/.config/nvim/im-select.exe 1033")
end

M.windowsInsertEnter = function()
  vim.cmd(":silent :!~/.config/nvim/im-select.exe 2052")
end
return M
