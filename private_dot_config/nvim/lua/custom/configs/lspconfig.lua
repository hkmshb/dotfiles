local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"

-- if you just want default config for the servers then put them in a table
local servers = {
  "clangd",
  "cssls",
  "gopls",
  "html",
  "pylsp",
  "templ",
  "tsserver",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup { blabla }

lspconfig.htmx.setup{}
lspconfig.golangci_lint_ls.setup{
  filetypes = {"go", "gomod"}
}
lspconfig.templ.setup{
  filetypes = {"templ"}
}
lspconfig.beancount.setup{
  init_options = {
    journal_file = "/Users/abdulhakeem/projects/vault/ledger/config.bean"
  }
}

configs.templ = {
  default_config = {
    cmd = { "templ", "lsp", "-http=localhost:7474", "-log=/tmp/templ.log" },
    filetypes = { "templ" },
    root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
    settings = {},
  },
}

configs.golangcilsp = {
  default_config = {
    cmd = { "golangci-lint-langserver" },
    root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
    init_options = {
      command = {
        "golangci-lint", "run", "--enable-all", "--disable",
        "lll", "--out-format", "json", "--issues-exit-code=1",
      }
    }
  }
}

