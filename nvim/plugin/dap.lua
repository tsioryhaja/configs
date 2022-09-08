local status, dap = pcall(require, 'dap')
if (not status) then return end

dap.adapters.python = {
	type = 'executable';
	command = 'python';
	args = {'-m', 'debugpy.adapter'};
}

dap.configurations.python = {
	{
		type = 'python';
		name = 'Debug Python';
		request = 'launch';

		program = function()
			return vim.fn.input("file to launch: ") 
		end,
		pythonPath = function()
			return 'python'
		end
	},
	{
		type = 'generic_remote',
		name = 'Python remote debug',
		request = 'attach',
		connect = {
			port = 5678,
			host = "127.0.0.1",
		},
		mode = "remote",
		cwd = vim.fn.getcwd(),
		pathMappings = {
			{
				localRoot = function()
					return vim.fn.input("Local code folder > ", vim.fn.getcwd(), "file")
				end,
				remoteRoot = function()
					return vim.fn.input("Container code folder > ", "/", "file")
				end
			}
		}
	}
}

dap.adapters.firefox = {
	type = 'executable',
	command = 'node',
	args = {'C:/vimdebugadapter/vscode-firefox-debug/dist/adapter.bundle.js'}
}

dap.adapters.node2 = {
	type = 'executable',
	command = 'node',
	args = {'C:/vimdebugadapter/vscode-node-debug2/out/src/nodeDebug.js'}
}

dap.configurations.typescript = {
	{
		name = 'Debug with firefox',
		type = 'firefox',
		request = 'launch',
		reAttach = true,
		url = 'http://localhost:4200',
		webRoot = '${workspaceFolder}',
		firefoxExecutable = 'C:/Program Files/Mozilla Firefox/firefox.exe',
	},
	{
		name = 'Debug node js',
		type = 'node2',
		request = 'launch',
		program = function()
			return vim.fn.getcwd() .. "/out/debug_adapter.js"
		end,
		sourceMaps = true,
		cwd = function()
			return vim.fn.getcwd()
		end,
		outDir = function()
			return vim.fn.getcwd() .. "/out"
		end,
	}
}

vim.keymap.set('n', '<F5>', function()
	require('dap').continue()
end)

vim.keymap.set('n', '<F9>', function()
	require('dap').toggle_breakpoint()
end)

vim.keymap.set('n', 'so', function()
	require('dap').step_over()
end)

vim.keymap.set('n', 'si', function()
	require('dap').step_into()
end)

vim.keymap.set('n', 'ro', function()
	require('dap').open()
end)

vim.keymap.set('n', ';duf', function()
	widgets = require'dap.ui.widgets'
	widgets.centered_float(widgets.scopes)
end)

vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='', linehl='', numhl=''})
