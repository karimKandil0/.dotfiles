require "nvchad.mappings"

local map = vim.keymap.set

-- NvChad has <leader>ff (find files), adding grep under same group
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
