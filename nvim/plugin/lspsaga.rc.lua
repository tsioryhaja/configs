local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup {
	server_filetype_map = {
		typescript = 'typescript'
	}
}


vim.fn.sign_define('DiagnosticSignError', {text='', texthl='DiagnosticSignError', numhl='DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignWarn', {text='', texthl='DiagnosticSignWarn', numhl='DiagnosticSignWarn'})
vim.fn.sign_define('DiagnosticSignInfo', {text='', texthl='DiagnosticSignInfo', numhl='DiagnosticSignInfo'})
vim.fn.sign_define('DiagnosticSignHint', {text='', texthl='DiagnosticSignHint', numhl='DiagnosticSignHint'})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gD', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', 'gld', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
