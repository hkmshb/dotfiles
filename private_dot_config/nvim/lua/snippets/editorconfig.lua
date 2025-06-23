local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

return {
  -- general .editorconfig snippet
  s(
    "editorconfig",
    fmt(
      [[
    root = true

    [*]
    charset = {}
    indent_size = {}
    indent_style = {}
    trim_trailing_whitespace = true
    insert_final_newline = true
  ]],
      {
        c(1, { t "utf-8", t "utf-16", t "latin1" }),
        i(2, "2"),
        c(3, { t "space", t "tab" }),
      }
    )
  ),

  -- golang override
  s(
    "ec-go",
    fmt(
      [[
    [{}]
    indent_size = 4
    indent_style = tab
  ]],
      {
        i(1, "*.go"),
      }
    )
  ),
}
