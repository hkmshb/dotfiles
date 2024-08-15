return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      -- source: github.com/mason-org/mason-registry
      -- target: formatters, linters, lsps
      ensure_installed = {
        -- dap
        "delve",

        -- formatters
        "goimports",
        "isort",
        "prettierd",
        "ruff",
        "sqlfmt",
        "stylua",

        -- linters
        "cspell",
        "djlint",
        "golangci-lint",
        "markdownlint",
        "rstcheck",
        "stylelint",

        -- lsp
        "css-lsp",
        "gopls",
        "html-lsp",
        "htmx-lsp",
        "jq-lsp",
        "lua-language-server",
        "sqls",
        "stylelint-lsp",
        "templ",
        "typescript-language-server",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- source: github.com/nvim-treesitter/nvim-treesitter
      -- target: code highlighting, folding, indentation
      ensure_installed = {
        "bash",
        "beancount",
        "c",
        "css",
        "csv",
        "dockerfile",
        "gitignore",
        "go",
        "gomod",
        "html",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "python",
        "regex",
        "rst",
        "styled",
        "templ",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "bufread",
    dependencies = {
      { "kevinhwang91/promise-async" },
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            -- foldfunc = "builtin",
            -- setopt = true,
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              {
                sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
                click = "v:lua.ScSa",
              },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
              {
                sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                click = "v:lua.ScSa",
              },
            },
          }
        end,
      },
    },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
      },
      {
        "zr",
        function()
          require("ufo").openFoldsExceptKinds()
        end,
      },
      {
        "zm",
        function()
          require("ufo").closeFoldsWith()
        end,
      },
      {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
      },
    },
    config = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:-,foldsep: ,foldclose:+]]
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup {
        open_fold_hl_timeout = 150,
        close_fold_kinds_for_ft = {
          default = { "imports", "comment" },
          json = { "array" },
          c = { "comment", "region" },
        },
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      }
    end,
  },
}
