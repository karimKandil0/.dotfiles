-- KEYBINDS
vim.g.mapleader = " "

-- Shift movement from HJKL to JKL;
-- j = Left, k = Down, l = Up, ; = Right
vim.keymap.set({ "n", "v", "o" }, "j", "h")
vim.keymap.set({ "n", "v", "o" }, "k", "j")
vim.keymap.set({ "n", "v", "o" }, "l", "k")
vim.keymap.set({ "n", "v", "o" }, ";", "l")

-- Map 'h' to the old ';' functionality (repeat f/t/F/T search)
vim.keymap.set({ "n", "v", "o" }, "h", ";")

-- Original File Explorer bind
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- UPDATED: Line bubbling (Alt Up/Down logic) 
-- K moves line down, L moves line up to match new layout
vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "L", ":m '<-2<CR>gv=gv")

-- Join lines (keeping cursor in place)
vim.keymap.set("n", "J", "mzJ`z")       

-- Scroll movement (Centered)
vim.keymap.set("n", "<C-d>", "<C-d>zz") 
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search navigation (Centered)
vim.keymap.set("n", "n", "nzzzv")       
vim.keymap.set("n", "N", "Nzzzv")

-- Paste and don't replace clipboard over deleted text
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Escape alias
vim.keymap.set("i", "<C-c>", "<Esc>")

-- UPDATED: Quickfix list scrolling
-- Control-K (Down) and Control-L (Up)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-l>", "<cmd>cprev<CR>zz")

-- Disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- UPDATED: Location list navigation
vim.keymap.set("n", "<leader>l", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

-- Doge / Documentation
vim.keymap.set("n", "<leader>dg", "<cmd>DogeGenerate<cr>")

-- PHP Linting
vim.keymap.set("n", "<leader>cc", "<cmd>!php-cs-fixer fix % --using-cache=no<cr>")

-- Replace word under cursor
vim.keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- SSH Clipboard yanking
vim.keymap.set('n', '<leader>y', '<Plug>OSCYankOperator')
vim.keymap.set('v', '<leader>y', '<Plug>OSCYankVisual')

-- Reload config
vim.keymap.set("n", "<leader>rl", "<cmd>source ~/.config/nvim/init.lua<cr>")

-- UndoTree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Quickfix list management
vim.keymap.set("n", "<leader>cl", ":cclose<CR>", { silent = true })
vim.keymap.set("n", "<leader>co", ":copen<CR>", { silent = true })
vim.keymap.set("n", "<leader>cn", ":cnext<CR>zz")
vim.keymap.set("n", "<leader>cp", ":cprev<CR>zz")
vim.keymap.set("n", "<leader>li", ":checkhealth vim.lsp<CR>", { desc = "LSP Info" })

-- Make
vim.keymap.set("n", "<leader>mm", "<cmd>make<CR>")

-- Source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
