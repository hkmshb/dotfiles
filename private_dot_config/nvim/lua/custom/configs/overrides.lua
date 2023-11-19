local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",

    -- extra
    "bash",
    "beancount",
    "go",
    "python",
    "sql",
    "templ",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- other stuff
    "bash-language-server",
    "beancount-language-server",
    "cssmodules-language-server",
    "eslint-lsp",
    "golangci-lint-langserver",
    "gopls",
    "htmx-lsp",
    "python-lsp-server",
    "sqls",
    "stylelint-lsp",
    "templ",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
