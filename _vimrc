set nocompatible
set hidden
set guioptions-=e

set backupdir=$HOME/.vim/backup_files//
set directory=$HOME/.vim/swap_files//
set undodir=$HOME/.vim/undo_files//

filetype plugin on
let NERDTreeIgnore = ['\.pyv$']
" full screen
au GUIEnter * simalt ~n
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
set laststatus=2

call plug#begin()
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/vim-lsp-settings'
Plug 'VundleVim/Vundle.vim'
Plug 'mileszs/ack.vim'
" Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
" Plug 'PhilRunninger/nerdtree-buffer-ops'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'puremourning/vimspector'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'tpope/vim-pathogen'
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'ggreer/the_silver_searcher'
" Plug 'rafi/awesome-vim-colorschemes'
Plug 'habamax/vim-godot'
" Plug 'girishji/scope.vim'
Plug 'itchyny/lightline.vim'
Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/async.vim'
" Plug 'vim-scripts/vimcompletesme'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/FuzzyFinder'
" Plug 'girishji/vimcomplete'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'tpope/vim-commentary'
Plug 'tsioryhaja/vimdap'
call plug#end()
let g:lightline = { 'colorscheme': 'wombat', 'background': 'dark' }
let g:lightline.enable = {
      \ 'statusline': 1,
      \ 'tabline': 1 }
" let g:lightline.tabline = {
"       \ 'left': [ [ 'tabs' ] ],
"       \ 'right': [ [ 'close' ] ] }

let g:lightline.tab = {
      \ 'active': [ 'filename', 'modified' ] }

let g:asyncomplete_auto_popup = 0

let g:lightline.component = {
			\ 'filename': '%f' }

" set pythonthreehome=C:\\Python310
" set pythonthreedll=python310.dll
"
" set pythonhome=C:\\Python310
" set pythondll=python310.dll
" let vimspector_base_dir='C:/Users/tsiory_re/.vim/plugged/vimspector'

" let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled=1
" let g:airline#extensions#tabline#tab_min_count=2
" let g:airline#extensions#branch#enabled=1
" let g:airline_theme='purify'
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
nmap <buffer> gd <plug>(lsp-definition)
nmap <buffer> gs <plug>(lsp-document-symbol-search)
nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
nmap <buffer> gr <plug>(lsp-references)
nmap <buffer> gi <plug>(lsp-implementation)
nmap <buffer> gt <plug>(lsp-type-definition)

nmap <Space>f :Files<CR>
" nmap <Space>F :FufCoverageFile<CR>
nmap <Space>F :FufFile<CR>
nmap <C-a> :CtrlPBuffer<CR>
" nnoremap ;f <scriptcmd>fuzzy.File()<cr>

" nmap <A-h> :tabprev<CR>
" nmap <A-l> :tabnext<CR>

nmap <C-n> :set rnu!<CR>

nmap <silent> <C-x> :execute "normal! `".toupper(nr2char(getchar()))."`\""<cr>

syntax on

" set t_Co=256
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

" imap <silent><expr> <Tab> pumvisible() ? "\<down>" : "\<Tab>"
" imap <silent><expr> <S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['hidden', 'ctrl-/']

set relativenumber
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always {}']}, <bang>1)
let g:display_virtual_text_diag = 0

let g:lsp_diagnostics_signs_enabled = 1

function! Lsp_toggle_virtual_text()
  if g:display_virtual_text_diag 
    let g:display_virtual_text_diag = 0
    call lsp#internal#diagnostics#virtual_text#_disable()
  else
    let g:display_virtual_text_diag = 1
    call lsp#internal#diagnostics#virtual_text#_enable()
  endif
endfunction

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
		imap <c-space> <Plug>(asyncomplete_force_refresh)
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <silent> gld <CR>:call Lsp_toggle_virtual_text()<CR>
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
		autocmd User lsp_buffer_enabled call lsp#internal#diagnostics#virtual_text#_disable()
augroup END

let &t_SI="\e[6 q"
let &t_EI="\e[2 q"

let g:display_virtual_text_diag = 0
let g:lsp_diagnostics_float_cursor = 1

let g:last_marked = 0
let g:marks_to_use = ['J', 'K', 'L', 'H', 'M', 'N']
function MarkForFastUse()
	if g:last_marked >= len(g:marks_to_use)
		return
	endif
	let l:mark_to_use = g:marks_to_use[g:last_marked]
	let g:last_marked = g:last_marked + 1
	execute ':mark '.l:mark_to_use
endfunction

nmap <a-r> :Rg<CR>

autocmd BufReadPost * call MarkForFastUse()


" ack.vim --- {{{

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" " Auto close the Quickfix list after pressing '<enter>' on a list item
" let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>
" }}}
