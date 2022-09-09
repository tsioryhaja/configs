local status, nvim_lsp = pcall(require, "lspconfig")

if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap = true, silent = true }

	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)

	buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
end

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.tsserver.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.gdscript.setup {
	on_attach = on_attach,
	capabilities=require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

nvim_lsp.gopls.setup {
	on_attach = on_attach,
	capabilities=require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

nvim_lsp.pyright.setup {
	on_attach = on_attach,
	capabilities=require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

nvim_lsp.clangd.setup {
	on_attach=on_attach,
	capabilities=require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

nvim_lsp.cmake.setup {
	on_attach=on_attach,
	capabilities=require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

nvim_lsp.angularls.setup {
	on_attach=on_attach,
	capabilities=require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

nvim_lsp.efm.setup {
	on_attach=on_attach,
	capabilities=require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	init_options = {documentFormatting=true},
	filetypes = {"python"},
	settings = {
		rootMarkers = {".git/"},
		languages={
			python={
				{formatCommand="black --quiet -", formatStdin=true}
			}
		}
	}
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local h1 = "DiagnosticSign"
	vim.fn.sign_define(h1, { text = icon, texth1 = h1, numh1 = ""})
end

vim.diagnostic.config({
	virtual_text = {
		prefix = '●'
	},
	update_in_insert = true,
	float = {
		source = "always",
	}
})
