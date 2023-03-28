local M = {}

-- 添加自己的输入法，可以在term使用im-select查看输入法名字
local Mac = {}
Mac.sougou = "com.sogou.inputmethod.sogou.pinyin"

M.defaultIM = "com.apple.keylayout.ABC"
M.currentIM = M.defaultIM


M.macInsertLeave = function()
  M.currentIM = vim.fn.system({ "im-select" })
  vim.cmd(":silent :!im-select" .. " " .. M.defaultIM)
end

M.macInsertEnter = function()
  if M.currentIM then
    if Mac.sougou then
      vim.cmd(":silent :!im-select" .. " " .. Mac.sougou)
    else
      vim.cmd(":silent :!im-select" .. " " .. M.currentIM)
    end
  else
    vim.cmd(":silent :!im-select" .. " " .. M.defaultIM)
  end
end

M.windowsInsertLeave = function()
  vim.cmd(":silent :!~/.config/nvim/im-select.exe 1033")
end

M.windowsInsertEnter = function()
  vim.cmd(":silent :!~/.config/nvim/im-select.exe 2052")
end
return M
