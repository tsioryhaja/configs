local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup {
  error_sign = "a",
	server_filetype_map = {
		typescript = 'typescript'
	},
  -- finder = {
  --   filter = {
  --     ['textDocument/definition'] = function (client_id, result) return true end,
  --     ['textDocument/references'] = function (client_id, result) return true end,
  --     ['textDocument/implementation'] = function (client_id, result) return true end,
  --   }
  -- }
}


vim.fn.sign_define('DiagnosticSignError', {text='', texthl='DiagnosticSignError', numhl='DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignWarn', {text='', texthl='DiagnosticSignWarn', numhl='DiagnosticSignWarn'})
vim.fn.sign_define('DiagnosticSignInfo', {text='', texthl='DiagnosticSignInfo', numhl='DiagnosticSignInfo'})
vim.fn.sign_define('DiagnosticSignHint', {text='', texthl='DiagnosticSignHint', numhl='DiagnosticSignHint'})

function define_severity_based_prefix(diagnostic)
  if diagnostic.severity == vim.diagnostic.severity.ERROR then
    return ''
  end
  if diagnostic.severity == vim.diagnostic.severity.WARN then
    return ''
  end
  if diagnostic.severity == vim.diagnostic.severity.INFO then
    return ''
  end
  if diagnostic.severity == vim.diagnostic.severity.HINT then
    return ''
  end
  return ''
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.keymap.set('n', ';K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gD', '<Cmd>Lspsaga finder<CR>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', 'gld', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', ';ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('n', '<A-p>', function ()
  require('lspsaga.symbol.winbar').toggle()
end)
