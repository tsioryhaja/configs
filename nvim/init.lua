vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.cmd'au BufNewFile,BufRead Jenkinsfile setf groovy'

require("plugins")
require("maps")
