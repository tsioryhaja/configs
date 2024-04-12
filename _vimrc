set nocompatible
filetype plugin on

let NERDTreeIgnore = ['\.pyv$']

let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_highlight_operators=1
let g:go_highlight_extra_types=1
let g:go_highlight_build_constraints=1
let g:go_highlight_generate_tags=1

filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'VundleVim/Vundle.vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'PhilRunninger/nerdtree-buffer-ops'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'puremourning/vimspector'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-pathogen'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ggreer/the_silver_searcher'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'habamax/vim-godot'
call plug#end()

set pythonthreehome=C:\\Python310
set pythonthreedll=python310.dll

set pythonhome=C:\\Python310
set pythondll=python310.dll
let vimspector_base_dir='C:/Users/tsiory_re/.vim/plugged/vimspector'
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline_theme='purify'
let g:vimspector_enable_mappings='HUMAN'
nmap <S-F3> :VimspectorReset<CR>
nmap <S-F7> :NERDTree<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap ;f :call fzf#run()<CR>

nmap <A-h> :tabprev<CR>
nmap <A-l> :tabnext<CR>

nmap <C-n> :set rnu!<CR>

colorscheme purify

syntax on

set t_Co=256
set encoding=utf-8
set mouse=a

set number

set tabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set guifont=SauceCodePro_Nerd_Font

set guioptions-=m "menu bar"
set guioptions-=T "toolbar"

let g:godot_executable = 'C:/Godot/Godot.exe'

imap <silent><expr> <Tab> pumvisible() ? "\<down>" : "\<Tab>"
imap <silent><expr> <S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''


let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']

set relativenumber

