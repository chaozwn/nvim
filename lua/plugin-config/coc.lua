local G = require('G')
G.opt.backup = false
G.opt.writebackup = false
G.opt.updatetime = 300
G.opt.signcolumn = "yes"
local opts = { silent = true, nowait = true }

vim.api.nvim_create_augroup("CocGroup", {})

-- Update signature help on jump placeholder
G.api.nvim_create_autocmd("User", {
  group = "CocGroup",
  pattern = "CocJumpPlaceholder",
  command = "call CocActionAsync('showSignatureHelp')",
  desc = "Update signature help on jump placeholder"
})

-- 显示Doc
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

function config()
  G.g.coc_global_extensions = {
    'coc-marketplace',
    '@yaegassy/coc-volar',
    'coc-emmet',
    'coc-tsserver',
    'coc-json',
    'coc-html',
    'coc-css',
    'coc-clangd',
    'coc-go',
    'coc-sumneko-lua',
    'coc-vimlsp',
    'coc-sh',
    'coc-db',
    'coc-pyright',
    'coc-toml',
    'coc-solidity',
    'coc-prettier',
    'coc-snippets',
    'coc-pairs',
    'coc-word',
    'coc-translator',
    'coc-git',
    'coc-yank'
  }
  G.cmd("command! -nargs=? Fold :call CocAction('fold', <f-args>)")
  G.cmd("hi! link CocPum Pmenu")
  G.cmd("hi! link CocMenuSel PmenuSel")
  G.map({
    -- 重命名
    { 'n', '<leader>lr', '<Plug>{coc-rename}',                 { silent = true } },
    -- 查看函数定义
    { 'n', 'gd',         '<Plug>{coc-definition}',             { silent = true } },
    { 'n', 'gt',         '<Plug>(coc-type-definition)',        { silent = true } },
    { 'n', 'gi',         '<Plug>{coc-implementation}',         { silent = true } },
    { 'n', 'gr',         '<Plug>(coc-references)',             { silent = true } },
    -- 选定整个function
    { 'x', 'if',         '<Plug>(coc-funcobj-i)',              { silent = true } },
    { 'o', 'if',         '<Plug>(coc-funcobj-i)',              { silent = true } },
    { 'x', 'af',         '<Plug>(coc-funcobj-a)',              { silent = true } },
    { 'o', 'af',         '<Plug>(coc-funcobj-a)',              { silent = true } },
    -- 选定整个class
    { 'x', 'ic',         '<Plug>(coc-classobj-i)',             { silent = true } },
    { 'o', 'ic',         '<Plug>(coc-classobj-i)',             { silent = true } },
    { 'x', 'ac',         '<Plug>(coc-classobj-a)',             { silent = true } },
    { 'o', 'ac',         '<Plug>(coc-classobj-a)',             { silent = true } },
    { 'n', '<leader>lj', '<CMD>lua _G.show_docs()<CR>',        { silent = true } },
    { 'n', 'gp',         '<Plug>(coc-diagnostic-prev)',        { silent = true } },
    { 'n', 'gn',         '<Plug>(coc-diagnostic-next)',        { silent = true } },
    -- 格式化代码
    -- { 'n', '<leader>fm', '<Plug>(coc-format-selected)<CR>',      {silent = true } },
    { 'n', '<leader>fm', ":call CocAction('format')<CR>",      { silent = true } },
    { 'x', '<leader>fm', '<Plug>(coc-format-selected)<CR>',    { silent = true } },
    -- 触发snippets
    { 'i', '<C-j>',      '<Plug>(coc-snippets-expand-jump)',   {} },
    -- Apply codeAction to the selected region
    { 'n', '<leader>la', '<Plug>{coc-codeaction-selected}',    { silent = true } },
    { 'x', '<leader>la', '<Plug>{coc-codeaction-selected}',    { silent = true } },
    -- Remap keys for applying codeActions to the current buffer
    { "n", "<leader>ac", "<Plug>{coc-codeaction}",             opts },
    -- Apply the most preferred quickfix action on the current line.
    { "n", "<leader>li", "<Plug>(coc-fix-current)",            opts },
    -- 启动复制框
    { "n", "<space>ly",  ":<C-u>CocList -A --normal yank<cr>", { silent = true } },
    -- 刷新提示框
    { 'i', '<C-space>',
      "coc#refresh()",
      {
        silent = true,
        noremap = true,
        expr = true
      } },
    -- tab为选中第一条
    { 'i', '<TAB>',
      "coc#pum#visible() ? coc#pum#confirm() :  \"\\<TAB>\"",
      {
        silent = true,
        noremap = true,
        expr = true
      } },
    { 'i', '<C-n>',
      "coc#pum#visible() ? coc#pum#next(1) : \"\\<C-n>\" ",
      {
        silent = true,
        noremap = true,
        expr = true
      } },
    { 'i', '<C-p>', "coc#pum#visible() ? coc#pum#prev(1) : \"\\<C-p>\"", {
      silent = true,
      noremap = true,
      expr = true
    } },
    { 'i', '<cr>', "coc#pum#visible() ? coc#pum#confirm() : \"\\<c-g>u\\<cr>\\<c-r>=coc#on_enter()\\<cr>\"",
      {
        silent = true,
        noremap = true,
        expr = true
      } },
    { 'n', '<F3>', ":silent CocRestart<cr>", {
      silent = true,
      noremap = true
    } },
    { 'n', '<F4>', "get(g:, 'coc_enabled', 0) == 1 ? ':CocDisable<cr>' : ':CocEnable<cr>'",
      {
        silent = true,
        noremap = true,
        expr = true
      } },
    { 'n', '<F9>', ":CocCommand snippets.editSnippets<cr>", {
      silent = true,
      noremap = true
    } },
    -- 列出所有的错误
    { 'n', '<c-e>', ":CocList --auto-preview diagnostics<cr>", { silent = true } },
    -- 翻译所在单词
    { 'n', 'mm',    "<Plug>(coc-translator-p)",                { silent = true } },
    { 'v', 'mm',    "<Plug>(coc-translator-pv)",               { silent = true } },
    -- 前往上一个git改动区域
    { 'n', '(',     "<Plug>(coc-git-prevchunk)",               { silent = true } },
    -- 前往下一个git改动区域
    { 'n', ')',     "<Plug>(coc-git-nextchunk)",               { silent = true } },
    { 'n', '<leader>lg',
      "get(b:, 'coc_git_blame', '') ==# 'Not committed yet' ? \"<Plug>(coc-git-chunkinfo)\" : \"<Plug>(coc-git-commit)\"",
      {
        silent = true,
        expr = true
      } },
    -- 可以显示每一行上次是谁提交的
    { 'n', '\\g',
      ":call coc#config('git.addGBlameToVirtualText',  !get(g:coc_user_config, 'git.addGBlameToVirtualText', 0)) | call nvim_buf_clear_namespace(bufnr(), -1, line('.') - 1, line('.'))<cr>",
      { silent = true } },
  })
end

config()
