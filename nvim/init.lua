vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors=true
vim.opt.cursorline=true

vim.cmd'au BufNewFile,BufRead Jenkinsfile setf groovy'

require("plugins")
require("maps")
require("execute")
SetEnvs()
