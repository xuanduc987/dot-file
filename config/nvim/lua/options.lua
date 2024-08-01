vim.opt.mouse = "n"

vim.opt.termguicolors = true

vim.opt.undofile = true

vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.shell = "/bin/sh"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.wrap = false

vim.opt.list = true
vim.opt.listchars = { tab = "» ", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.scrolloff = 10

-- default white space options
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

-- User rg if possible
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l%m,%f  %l%m"
end
