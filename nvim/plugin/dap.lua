local status, dap = pcall(require, 'dap')
if (not status) then return end

require('dap_adapters.configs')

local load_config = function()
	local file = io.open('.dap.json','r')
	local content = nil
	if file then
		local c = file:read('*a')
		content = vim.json.decode(c)
	end
	return content
end

local get_config = function(name)
	local value = nil
	local config = load_config()
	if config then
		value = config[name]
	end
	return value
end

local get_config_or_ask = function(name, asked)
	local value = get_config(name)
	if value == nil then
		value = vim.fn.input(asked)
	end
	return value
end

dap.adapters.python = {
	type = 'executable';
	command = 'python';
	args = {'-m', 'debugpy.adapter'};
}

dap.adapters.python_remote = {
	type = 'server',
	host = '127.0.0.1',
	port = 5678,
	request = 'attach'
}

dap.configurations.python = {
	{
		type = 'python',
		name = 'Run current file',
		request = 'launch',
		program = '${file}'
	},
	{
		type = 'python';
		name = 'Debug Python';
		request = 'launch';

		program = function()
			local program = get_config('program')
			if program == nil then
				program = vim.fn.input("file to launch: ")
			end
			return program
		end
	},
	{
		type = 'python_remote',
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
					return vim.fn.input("Container code folder > ", vim.fn.getcwd(), "file")
				end
			}
		}
	},
	
}

dap.adapters.godot = {
	type = 'executable',
	command = 'node',
	args = {'E:/data/nodeprojects/godot-dap-adapter/out/debug_adapter.js', vim.fn.getcwd()},
	cwd = vim.fn.getcwd(),
}

dap.adapters.firefox = {
	type = 'executable',
	command = 'node',
	args = {'C:/vimdebugadapter/vscode-firefox-debug/dist/adapter.bundle.js'}
}

dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = {'C:/vimdebugadapter/vscode-chrome-debug/out/src/chromeDebug.js'}
}

dap.adapters.node2 = {
	type = 'executable',
	command = 'node',
	args = {'C:/vimdebugadapter/vscode-node-debug2/out/src/nodeDebug.js'}
}

dap.configurations.gdscript = {
	{
		name = 'Debug file',
		type = 'godot',
		request = 'launch',
		program = function()
			return vim.fn.input("File :")
		end
	}
}

dap.configurations.typescript = {
	{
		name = 'Attach to firefox',
		type = 'firefox',
		request = 'attach',
		reAttach = true,
		url = 'http://localhost:4200',
		webRoot = '${workspaceFolder}',
		cwd = vim.fn.getcwd(),
		sourceMaps=true,
	},
	{
		name = 'Attach to chrome 2',
		type="chrome",
		request="attach",
		url = 'http://localhost:4200/*',
		cwd=vim.fn.getcwd(),
		protocol="inspector",
		port=9222,
		webRoot="${workspaceFolder}",
		sourceMaps=true,
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

dap.adapters.cppdbg = {
	id='cppdbg',
	type='executable',
	-- command = 'C:\\Users\\tsiory_re\\projects\\opensource\\cpptools-win64\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
	command = 'C:\\vimdebugadapter\\ms-vscode.cpptools\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
	options = {
		detached = false,
    runInTerminal = true
	},
  runInTerminal = true
}

dap.adapters.lldb = {
	type = 'executable',
	command = 'lldb-vscode',
	name = 'lldb',
	env = {
		LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
	}
}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = 'C:\\vimdebugadapter\\codelldb-x86_64-windows\\extension\\adapter\\codelldb.exe',
    args = {"--port", "${port}"},
    detached = false,
  }
}

dap.configurations.cpp = {
	{
		name = "Launch CPP Executable",
		type = "cppdbg",
		request = "launch",
		program = function ()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = true,
    runInTerminal = true
	},
	{
		name = "Launch CPP LLDB",
		type = "lldb",
		request = 'launch',
		program = function ()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = true,
		args = {}
	},
  {
    name = "CodeLLDB",
    type = "codelldb",
    request = "launch",
    program = function ()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
    end,
    cwd = "${workspaceFolder}",
  }
}

GetConfigs(dap)


vim.keymap.set('n', '<F5>', function()
	require('dap').continue()
end)

vim.keymap.set('n', ';ds', function()
	require('dap').continue()
end)

vim.keymap.set('n', '<F9>', function()
	require('dap').toggle_breakpoint()
end)

vim.keymap.set('n', ';db', function()
	require('dap').toggle_breakpoint()
end)

vim.keymap.set('n', 'dso', function()
	require('dap').step_over()
end)

vim.keymap.set('n', 'dsi', function()
	require('dap').step_into()
end)

vim.keymap.set('n', 'dro', function()
	require('dap').repl.open()
end)

vim.keymap.set('n', 'drc', function()
	require('dap').repl.close()
end)

vim.keymap.set('n', ';dt', function()
	require('dap').terminate()
end)

vim.keymap.set('n', ';duf', function()
	local widgets = require'dap.ui.widgets'
	widgets.centered_float(widgets.scopes)
end)

local function setConditionalBreakPoint()
	vim.ui.input({
		prompt = "Condition: ",
	}, function(input)
		require('dap').set_breakpoint(input)
	end)
end

vim.keymap.set('n', ';dcb',function()
	setConditionalBreakPoint()
end)

vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='', linehl='', numhl=''})


local status_dapui, dapui = pcall(require, 'dapui')
if (not status_dapui) then return end

dapui.setup(
  {
    controls = {
      icons = {
        pause = "",
        play = "",
        step_into = "",
        step_over = "",
        step_out = "",
        step_back = "",
        run_last = "",
        terminate = "",
      }
    }
  }
)

vim.keymap.set('n', ';dui', function()
	dapui.toggle()
end)
