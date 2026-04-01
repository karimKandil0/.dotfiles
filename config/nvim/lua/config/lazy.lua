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

require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
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
  },

  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local lspconfig = require("lspconfig")

      local ts_name = lspconfig.ts_ls and "ts_ls" or "tsserver"
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", ts_name, "pyright", "bashls", "jsonls" },
        automatic_installation = true,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local servers = { "lua_ls", ts_name, "pyright", "bashls", "jsonls" }
      for _, server in ipairs(servers) do
        if lspconfig[server] then
          lspconfig[server].setup({ capabilities = capabilities })
        end
      end
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }),
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.schedule(function()
          vim.notify("nvim-treesitter not ready yet; run :Lazy sync", vim.log.levels.WARN)
        end)
        return
      end

      ts.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "bash", "json", "python", "javascript", "typescript" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },

  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = true,
  },

  {
    "numToStr/Comment.nvim",
    config = true,
  },
}, {
  checker = { enabled = false },
  lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
})
