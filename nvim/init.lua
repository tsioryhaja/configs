vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors=true
vim.opt.cursorline=true


vim.cmd "filetype on"
vim.cmd'au BufNewFile,BufRead Jenkinsfile setf groovy'
vim.cmd'au BufNewFile,BufRead *.coffee set filetype=coffee'
vim.cmd':set signcolumn=yes:1'
vim.cmd':set relativenumber'

require("plugins")
require("maps")
require("execute")
SetEnvs()
require("executor.cmd")
vim.cmd ":set nofixendofline"

require('local_utils.intro')
