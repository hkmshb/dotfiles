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


lspconfig.beancount.setup{
  init_options = {
    journal_file = "/Users/abdulhakeem/projects/vault/ledger/config.bean"
  }
}

lspconfig.golangci_lint_ls.setup{
  filetypes = {"go", "gomod"}
}

lspconfig.htmx.setup{}
lspconfig.templ.setup{
  filetypes = {"templ"}
}

lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      configurationSources = {'flake8'},
      plugins = {
        -- formatter options
        black = {enabled=true},
        autopep8 = {enabled=false},
        yapf = {enabled=false},
        -- linter options
        flake8 = {enabled=true, indentSize=2, maxLineLength=100},
        mccable= {enaled=false},
        pycodestyle= {enabled=false},
        pyflake = {enabled=false},
        pylint = {enabled=false},
        -- import sorting
        pyls_isort = {enabled=true},
      }
    }
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
