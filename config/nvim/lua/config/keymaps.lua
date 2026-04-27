local map = vim.keymap.set

-- Existing workflow
map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { silent = true, desc = "Find files" })
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { silent = true, desc = "Live grep" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { silent = true, desc = "Toggle tree" })
map("n", "<leader>w", "<cmd>w<cr>", { silent = true, desc = "Write" })
map("n", "<leader>x", "<cmd>wq<cr>", { silent = true, desc = "Write + quit" })
map("n", "<leader>q", "<cmd>q<cr>", { silent = true, desc = "Quit" })

-- LSP workflow
map("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Goto references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

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

-- Buffer navigation
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprev<cr>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Close buffer" })

-- Window splits
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<C-h>", "<C-w>h", { desc = "Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Move right" })

-- Telescope extras
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Grep word under cursor" })

-- QoL
map("n", "<leader>nh", "<cmd>nohl<cr>", { desc = "Clear highlights" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("v", "<leader>p", '"_dP', { desc = "Paste without yanking" })
