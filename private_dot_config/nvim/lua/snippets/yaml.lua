local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local i = ls.insert_node

return {
  -- general golangci
  s(
    "golangci",
    fmt(
      [[
    version: "2"
    run:
      go: "{}"
      timeout: 5m

    linters:
      default: none
      enable:
        - dupl
        - govet
        - ineffassign
        - misspell
        - nakedret
        - revive
        - unused
        - staticcheck
      settings:
        revive:
          rules:
            # https://github.com/mgechev/revive/blob/master/RULES_DESCRIPTIONS.md#exported
            - name: exported
              severity: warning
              disabled: true

    formatters:
      enable:
        - gofmt
        - goimports
      settings:
        gofmt:
          simplify: true
      ]],
      {
        i(1, "1.24"),
      }
    )
  ),

  -- pre-commit snippet
  s(
    "precommit",
    fmt(
      [[
    repos:
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v5.0.0
        hooks:
          - id: check-json
          - id: check-merge-conflict
          - id: check-yaml
          - id: trailing-whitespace
     ]],
      {}
    )
  ),

  -- golang hooks
  s(
    "pc-go",
    fmt(
      [[
      - repo: https://github.com/dnephin/pre-commit-golang
        rev: v0.5.1
        hooks:
          - id: golangci-lint
 
  ]],
      {}
    )
  ),
}
