-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = { "cssls", "html", "gopls", "pyright", "ts_ls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })

  vim.lsp.enable(lsp)
end

vim.lsp.config("jqls", {})
vim.lsp.enable "jqls"

vim.lsp.config("stylelint_language_server", {})
vim.lsp.enable "stylelint_language_server"

vim.lsp.config("templ", {
  filetypes = { "templ" },
})
vim.lsp.enable "templ"

vim.lsp.config("htmx", {})
vim.lsp.enable "htmx"
