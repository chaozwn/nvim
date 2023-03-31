local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("没有找到 bufferline")
  return
end

-- bufferline 配置
-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
  options = {
    themable = true,
    -- 关闭 Tab 的命令
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    -- 侧边栏配置
    -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
    -- 使用 nvim 内置 LSP  后续课程会配置
    diagnostics = "coc",
    -- 可选，显示 LSP 报错图标
    ---@diagnostic disable-next-line: unused-local
    max_name_length = 18,
    max_prefix_length = 1,
    diagnostics_update_in_insert = true,
    separator_style = "thin",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local arr = {} -- 创建一个空数组
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        table.insert(arr, n .. ' ' .. sym) -- 将拼接后的数据添加到数组中
      end
      return table.concat(arr, ' ')        -- 将数组元素连接成一个字符串输出
    end,
  },
})
