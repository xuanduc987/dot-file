local group = vim.api.nvim_create_augroup("diagnostic_on_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
  group = group,
  callback = function()
    vim.diagnostic.config({ virtual_lines = { current_line = true } })
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "CursorMoved", "InsertEnter" }, {
  group = group,
  callback = function()
    vim.diagnostic.config({ virtual_lines = false })
  end,
})
