local map = vim.keymap.set

-- Existing workflow
map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { silent = true, desc = "Find files" })
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { silent = true, desc = "Live grep" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { silent = true, desc = "Toggle tree" })
map("n", "<leader>w", "<cmd>w<cr>", { silent = true, desc = "Write" })
map("n", "<leader>x", "<cmd>wq<cr>", { silent = true, desc = "Write + quit" })
map("n", "<leader>q", "<cmd>q<cr>", { silent = true, desc = "Quit" })

-- LSP workflow
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Goto references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format" })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Git
map("n", "<leader>gg", function()
  local ok, gs = pcall(require, "gitsigns")
  if ok then gs.preview_hunk() end
end, { desc = "Preview git hunk" })

-- Which-key helper
map("n", "<leader>?", "<cmd>WhichKey<cr>", { silent = true, desc = "WhichKey" })
