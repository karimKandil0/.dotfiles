local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true

local telescope = {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
}

local tree = {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = { side = "left", width = 28 },
      renderer = { group_empty = true },
      filters = { dotfiles = false },
      actions = { open_file = { quit_on_open = true } },
    })
  end,
}

require("lazy").setup({ telescope, tree })

vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { silent = true })
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>wq<cr>", { silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { silent = true })
