vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git","clone","--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {"nvim-tree/nvim-tree.lua", dependencies = {"nvim-tree/nvim-web-devicons"}},
  {"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}},
  {"lewis6991/gitsigns.nvim"}
})

require("nvim-tree").setup()
require("gitsigns").setup()

local telescope = require("telescope.builtin")

vim.keymap.set("n","<leader>e",":NvimTreeToggle<CR>")
vim.keymap.set("n","<leader>ff",telescope.find_files)
vim.keymap.set("n","<leader>fg",telescope.live_grep)
