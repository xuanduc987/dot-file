vim.diagnostic.config({
  underline = true,
  update_in_insert = false, -- false so diags are updated on InsertLeave
  virtual_lines = { current_line = true },
  severity_sort = true,
})
