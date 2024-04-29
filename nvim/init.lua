vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors=true
vim.opt.cursorline=true

require('theme')

vim.cmd "filetype on"
vim.cmd'au BufNewFile,BufRead Jenkinsfile setf groovy'
vim.cmd'au BufNewFile,BufRead *.coffee set filetype=coffee'
vim.cmd':set signcolumn=yes:1'
vim.cmd':set relativenumber'
vim.cmd':set list listchars=tab:▏\\ ,trail:▏,precedes:▏,extends:▏'
vim.cmd':set list!'

vim.keymap.set('n', ';it', '<CMD>set list!<CR>')
vim.keymap.set('n', ';n', '<CMD>bnext<CR>')
vim.keymap.set('n', ';p', '<CMD>bprev<CR>')

require("plugins")
require("maps")
require("execute")
SetEnvs()
require("executor.cmd")
vim.cmd ":set nofixendofline"

require('local_utils.intro')

-- to duplicate row use :t.<CR>

-- local home_folder = vim.env.HOME
-- use marks in vim:
--  'a : jump mark a line
--  ma : set mark a to current line
-- ee what<C-i> and <C-o> actually do when you code
-- and learn to use ci too. for changin what's inside of a '' of () and anything
-- learn to use th i after the mode like vi( ci{ di"
