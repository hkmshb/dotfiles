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
        "biome",
        "goimports",
        "isort",
        "oxfmt",
        "ruff",
        "sqlfmt",
        "stylua",

        -- linters
        "oxlint",
        -- "cspell",
        -- "djlint",
        -- "golangci-lint",
        -- "markdownlint",
        -- "rstcheck",
        -- "stylelint",

        -- lsp
        "css-lsp",
        "css-variables-language-server",
        "cssmodules-language-server",
        "gopls",
        "html-lsp",
        "htmx-lsp",
        "jq-lsp",
        "lua-language-server",
        "pyright",
        "sqls",
        "stylelint-language-server",
        "templ",
        "typescript-language-server",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- Neovim 0.12 changed match[id] from a single TSNode to a list of nodes.
      -- nvim-treesitter master hasn't adapted, so directives crash with
      -- "attempt to call method 'range' (a nil value)". Re-register the affected
      -- directives with an unwrap shim. Survives :Lazy update.
      local query = require "vim.treesitter.query"
      local force = vim.fn.has "nvim-0.10" == 1 and { force = true, all = false } or true
      local function get_node(match, id)
        local v = match[id]
        if type(v) == "table" then return v[1] end
        return v
      end

      local html_script_type_languages = {
        importmap = "json",
        module = "javascript",
        ["application/ecmascript"] = "javascript",
        ["text/ecmascript"] = "javascript",
      }
      local md_alias = { ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript" }

      query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
        local node = get_node(match, pred[2])
        if not node then return end
        local val = vim.treesitter.get_node_text(node, bufnr)
        local configured = html_script_type_languages[val]
        if configured then
          metadata["injection.language"] = configured
        else
          local parts = vim.split(val, "/", {})
          metadata["injection.language"] = parts[#parts]
        end
      end, force)

      query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
        local node = get_node(match, pred[2])
        if not node then return end
        local alias = vim.treesitter.get_node_text(node, bufnr):lower()
        local ft = vim.filetype.match { filename = "a." .. alias }
        metadata["injection.language"] = ft or md_alias[alias] or alias
      end, force)

      query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
        local id = pred[2]
        local node = get_node(match, id)
        if not node then return end
        local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
        if not metadata[id] then metadata[id] = {} end
        metadata[id].text = string.lower(text)
      end, force)
    end,
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
        "editorconfig",
        "elvish",
        "gitignore",
        "go",
        "gomod",
        "gotmpl",
        "helm",
        "html",
        "htmldjango",
        "ini",
        "javascript",
        "jinja",
        "jinja_inline",
        "jq",
        "jsdoc",
        "json",
        "jsonc",
        "just",
        "mermaid",
        "make",
        "nginx",
        "lua",
        "luadoc",
        "proto",
        "python",
        "regex",
        "requirements",
        "rst",
        "rust",
        "sql",
        "styled",
        "svelte",
        "templ",
        "terraform",
        "todotxt",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
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
  {
    "nicolasgb/jj.nvim",
    version = "*", -- Use latest stable release
    lazy = false,
    -- Or from the main branch (uncomment the branch line and comment the version line)
    -- branch = "main",
    config = function()
      require("jj").setup {}
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
    },
    config = function()
      require("codecompanion").setup {
        adapters = {
          acp = {
            opencode = function()
              return require("codecompanion.adapters").extend("opencode", {
                defaults = {
                  mode = "plan",
                  mcpServers = "inherit_from_config",
                },
              })
            end,
          },
        },
        interactions = {
          chat = {
            adapter = "opencode",
          },
        },
      }
    end,
  },
}
