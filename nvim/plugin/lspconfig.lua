local status, nvim_lsp = pcall(require, "lspconfig")

if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap = true, silent = true }

	buf_set_keymap('n', 'gd', '<Cmd>tab split | lua vim.lsp.buf.declaration()<CR>', opts)

	buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
end

load_config = function()
	file = io.open('.lsp.json','r')
	content = nil
	if file then
		c = file:read('*a')
		content = vim.json.decode(c)
	end
	return content
end

get_config = function(name)
	value = nil
	config = load_config()
	if config then
		value = config[name]
	end
	return value
end

local python_version = get_config('python_version')

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

local function get_default_capabilities()
	if require('cmp_nvim_lsp').default_capabilities == nil then
		return require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
	else
		return require('cmp_nvim_lsp').default_capabilities()
	end	
end

local capabilities = get_default_capabilities()
local util = require 'lspconfig.util'
local nvim_lsp_configs = require 'lspconfig.configs'

nvim_lsp_configs['pyls'] = {
	default_config = {
		cmd = { 'pyls' },
		filetypes = { 'python' },
		root_dir = function(fname) 
			local root_files = {
			'pyproject.toml',
			'setup.py',
			'setup.cfg',
			'requirements.txt',
			'Pipfile',
			}
			return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
		end,
		single_file_support = true,
	},
	docs = {
		description = [[
		let's try a python 2.7 lsp
		]]
	}
}

nvim_lsp.tsserver.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.gdscript.setup {
	on_attach = on_attach,
	capabilities=get_default_capabilities(),
}

nvim_lsp.gopls.setup {
	on_attach = on_attach,
	capabilities=get_default_capabilities(),
}

if python_version == '2.7' then
	print(python_version)
	nvim_lsp.pyls.setup {
		on_attach = on_attach,
		capabilities=get_default_capabilities(),
	}
else
	nvim_lsp.pyright.setup {
		on_attach = on_attach,
		capabilities=get_default_capabilities(),
	}
end

nvim_lsp.clangd.setup {
	on_attach=on_attach,
	capabilities=get_default_capabilities(),
}

nvim_lsp.cmake.setup {
	on_attach=on_attach,
	capabilities=get_default_capabilities(),
}

nvim_lsp.angularls.setup {
	on_attach=on_attach,
	capabilities=get_default_capabilities(),
}

nvim_lsp.efm.setup {
	on_attach=on_attach,
	capabilities=get_default_capabilities(),
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

nvim_lsp.sumneko_lua.setup {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals={'vim'},
			},
			workspace={
				library=vim.api.nvim_get_runtime_file("", true),
			},
			telemetry={
				enable=false,
			},
		}
	},
	on_attach=on_attach,
	capabilities=get_default_capabilities(),
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
