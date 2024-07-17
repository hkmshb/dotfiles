local opt = vim.opt

-- foldings
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

-- display vertical rulers
opt.colorcolumn = "80,100"

-- register new filetype
vim.filetype.add({
  extension = {
    templ = "templ",
    bean = "beancount",
  },
})

