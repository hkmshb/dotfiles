local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "biome" },
    -- html = { "prettier" },
    json = { "biome" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    go = { "goimports", "gofmt" },
    python = { "isort", "ruff_format" },
    ["templ"] = { "templ" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
