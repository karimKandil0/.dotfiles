vim.g.mapleader = " "

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.g.rustfmt_autosave = 0
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.rs",
  callback = function()
    pcall(vim.api.nvim_del_augroup_by_name, "rust.vim.PreWrite")
  end,
})
