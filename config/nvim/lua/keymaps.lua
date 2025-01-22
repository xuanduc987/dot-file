vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "gC", vim.diagnostic.setqflist)

vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>w", "<cmd>update<CR>")
vim.keymap.set("n", "<leader>f", ":grep<space>")
vim.keymap.set("n", "<leader>e", ":edit <C-R>=fnameescape(expand('%:h')).'/'<cr>")
vim.keymap.set("n", "<leader>x", ":split <C-R>=fnameescape(expand('%:h')).'/'<cr>")
vim.keymap.set("n", "<leader>v", ":vsplit <C-R>=fnameescape(expand('%:h')).'/'<cr>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

vim.keymap.set("n", "<Leader>=", "<C-w>=")

-- Toggle paste mode
vim.keymap.set("n", "4", ":set invpaste<CR>:set paste?<CR>")

-- expand current directory
vim.keymap.set("c", "%%", "<C-R>=fnameescape(expand('%:h')).'/'<cr>")
-- expand home directory
vim.keymap.set("c", "$$", "<C-R>=fnameescape(expand('~')).'/'<cr>")

-- In command-line mode, C-p use history to complete
vim.keymap.set("c", "<C-P>", "<Up>")

-- readline mapping
vim.keymap.set("c", "<c-a>", "<home>")
vim.keymap.set("c", "<c-b>", "<left>")
vim.keymap.set("c", "<c-f>", "<right>")

-- replace last search
vim.keymap.set("n", "<leader>s", ":%s//")
vim.keymap.set("x", "<leader>s", ":s//")

-- easy upper case
vim.keymap.set("i", "<c-u>", "<left><c-o>:normal gUiwea<CR><right>")

-- Easy copy-paste
vim.keymap.set("x", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("x", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>p", '"+p')

-- Magic search
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("n", "?", "?\\v")

if not vim.fn.has("nvim-0.11") then
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

  vim.keymap.set("n", "[a", "<cmd>previous<CR>")
  vim.keymap.set("n", "]a", "<cmd>next<CR>")
  vim.keymap.set("n", "[b", "<cmd>bprevious<CR>")
  vim.keymap.set("n", "]b", "<cmd>bnext<CR>")
  vim.keymap.set("n", "[q", "<cmd>cprevious<CR>")
  vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
  vim.keymap.set("n", "[l", "<cmd>lprevious<CR>")
  vim.keymap.set("n", "]l", "<cmd>lnext<CR>")
  -- insert blank line
  vim.keymap.set("n", "[<space>", ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[")
  vim.keymap.set("n", "]<space>", ":<c-u>put =repeat(nr2char(10), v:count1)<cr>']")
end
