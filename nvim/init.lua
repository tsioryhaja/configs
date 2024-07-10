vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors=true
vim.opt.cursorline=false

require('theme')
require('local_utils.configs')
SetDefaultLocation()
-- require('tablines')

vim.cmd "filetype on"
vim.cmd'au BufNewFile,BufRead Jenkinsfile setf groovy'
vim.cmd'au BufNewFile,BufRead *.coffee set filetype=coffee'
vim.cmd':set signcolumn=yes:1'
vim.cmd':set relativenumber'
vim.cmd':set list listchars=tab:▏\\ ,trail:▏,precedes:▏,extends:▏'
vim.cmd':set list!'
-- vim.o.tabline = '%!v:lua.require\'tablines\'.MyTabline()'

-- vim.keymap.set('n', '<C-x>', function ()
--   vim.cmd("normal! `"..string.upper(vim.fn.nr2char(vim.fn.getchar()))..'`"')
-- end)

vim.cmd':nmap <silent> <C-x> :execute " normal! `".toupper(nr2char(getchar()))."`\\""<cr>'
-- vim.cmd':nmap <silent> ;w :w<cr>'
-- if vim.fn.has('windows') then
--   vim.cmd':set undodir=C:\\tools\\neovim\\.undodir'
--   vim.cmd':set undofile'
-- end

vim.keymap.set('n', '<A-^>', function ()
  if vim.o.laststatus == 2 then
    vim.o.laststatus = 1
  else
    vim.o.laststatus = 2
  end
end)
vim.keymap.set('n', ';it', '<CMD>set list!<CR>')
vim.keymap.set('n', '<A-o>', '<CMD>bnext<CR>')
vim.keymap.set('n', '<A-i>', '<CMD>bprev<CR>')

require("plugins")
require("maps")
require("execute")
SetEnvs()
require("executor.cmd")
vim.cmd ":set nofixendofline"

vim.cmd":silent! colorscheme vim"

vim.g.loaded_python3_provider=0

-- require('local_utils.intro')

-- to duplicate row use :t.<CR>

-- local home_folder = vim.env.HOME
-- use marks in vim:
--  'a : jump mark a line
--  ma : set mark a to current line
-- ee what<C-i> and <C-o> actually do when you code
-- and learn to use ci too. for changin what's inside of a '' of () and anything
-- learn to use th i after the mode like vi( ci{ di"
-- learn to use the CTRL-6 command, it is better to master that than use harpoon
-- on telescope when searching file use CTRL + q to move it to a quickfix window
-- you can use cdo to to execute soem action on each occurence on the quick fix
-- learn some quickfix command to manage some easy tricks with :cn to go to next thing in the list, :cp to go to previos and every thing
-- next :cdo for an action in aoo of the line quickly
-- example :cdo s/main/Main/gc
-- :cdo is really awsome and the gc at the end of the search and replace is also really awsome
--
-- search \(.*\) is the way to select everything
--
-- in search \1 to get the first selected 
-- 
-- telescope scroll on preview <C-d> and <C-u>
