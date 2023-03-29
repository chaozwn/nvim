local status, leap = pcall(require, "leap")
if not status then
  vim.notify("没有找到 leap")
  return
end

-- leap.add_default_mappings()
leap.opts.highlight_unlabeled_phase_one_targets = true
