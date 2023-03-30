local status, substitute = pcall(require, "substitute")
if not status then
  vim.notify("没有找到 substitute")
  return
end

substitute.setup({
  on_substitute = nil,
  yank_substituted_text = false,
  highlight_substituted_text = {
    enabled = true,
    timer = 500,
  },
  range = {
    prefix = "s",
    prompt_current_text = false,
    confirm = false,
    complete_word = false,
    motion1 = false,
    motion2 = false,
    suffix = "",
  },
  exchange = {
    motion = false,
    use_esc_to_cancel = true,
  },
})

require("keybindings").mapSubstitute(substitute)
require("keybindings").mapSubstituteExchange(require("substitute.exchange"))
