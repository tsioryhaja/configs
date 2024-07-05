local status, dap = pcall(require, 'dap')
if (not status) then return end

local utils = require('dap.utils')


local rpc = require('dap.rpc')

require('dap_adapters.msvc')

require('dap_adapters.python')

require('dap_adapters.configs')

dap.listeners.before['event_debugpySockets'] = {DebugpySocketsHandler}

local home_folder = vim.env.HOME

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
	options = {
    source_filetype = 'python',
	},
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
	type = 'server',
	host = '127.0.0.1',
	port = 6006,
	-- port = 6007,
  debugServer = 6006,
  launchScene = true,
  launchGameInstance = false,
  pathMappings = {
    {
      localRoot = function()
        -- return vim.fn.input("Local code folder > ", vim.fn.getcwd(), "file")
        return vim.fn.getcwd()
      end,
      remoteRoot = function()
        -- return vim.fn.input("Container code folder > ", vim.fn.getcwd(), "file")
        return "res:/"
      end
    }
	}
}

dap.adapters.firefox = {
	type = 'executable',
	command = 'node',
	args = {DebugPaths['firefox']}
}

dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = {DebugPaths['chrome']}
}

dap.adapters.node2 = {
	type = 'executable',
	command = 'node',
	args = {DebugPaths['node']}
}

dap.configurations.gdscript = {
	{
	  type = 'godot',
		request = 'launch',
		name = 'Launch game',
    project = "${workspaceFolder}",
	},
	{
	  type = 'godot',
		request = 'attach',
		name = 'Attach game',
    project = "${workspaceFolder}",
	},

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
  -- command = 'C:\\debugadapter\\cpptools-win64\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
  command = 'powershell',
  args = { '/c', DebugPaths['cppdbg'] },
	-- command = 'C:\\vimdebugadapter\\ms-vscode.cpptools\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
	options = {
		detached = false,
    externalTerminal = true,
	},
}

dap.defaults.fallback.external_terminal = {
  command = "cmd.exe",
  args = {'/c'}
}

local function run_in_terminal(self, payload)
  utils.notify(vim.json.encode(payload))
end

dap.adapters.cppvsdbg = {
	id='cppvsdbg',
	type='executable',
  command = DebugPaths['vsdbg'],
  args = { "--interpreter=vscode" },
	options = {
    externalTerminal = true,
    -- logging = {
    --   moduleLoad = false,
    --   trace = true
    -- }
	},
  runInTerminal =  true,
  reverse_request_handlers = {
    handshake = RunHandshake,

  },
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
    externalTerminal = true,
    -- runInTerminal = true
	},
  {
    name = 'Try vsdbg',
    type = "cppvsdbg",
    request = "launch",
    program = function ()
      return vim.fn.input('Path: ', vim.fn.getcwd() .. '\\Debug\\test.exe', 'file')
    end,
    cwd = vim.fn.getcwd(),
    clientID = 'vscode',
    clientName = 'Visual Studio Code',
    externalTerminal = true,
    columnsStartAt1 = true,
    linesStartAt1 = true,
    locale = "en",
    pathFormat = "path",
    externalConsole = true
    -- console = "externalTerminal"
  }
}

GetConfigs(dap)


vim.keymap.set('n', '<F5>', function()
	require('dap').continue()
end)

vim.keymap.set('n', ';ds', function()
	require('dap').continue()
end)

vim.api.nvim_create_user_command("DapRun", function ()
	require('dap').continue()
end, {})

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

vim.api.nvim_create_user_command("DapSaveBreakpoints", function(ctx)
  local breakpoints = require('dap.breakpoints').get()
  local breakpoints_configs = {}
  local n = 0
  for i, bp in pairs(breakpoints) do
    if bp ~= nil then
      local bf = {
        file = vim.api.nvim_buf_get_name(i),
        breakpoints = bp
      }
      table.insert(breakpoints_configs, bf)
    end
  end
  local filename = ctx.args or ".breakpoints.json"
  local file = io.open(filename, 'w')
  file:write(vim.json.encode({breakpoints = breakpoints_configs}))
  file:close()
end, {nargs="*"})

-- vim.api.nvim_create_user_command("DapLoadBreakpoints", function (ctx)
--   local file = io.open(ctx.args, "r")
--   local d = file:read('*a')
--   local contents = vim.json.decode(d)
--   local cwd = vim.fn.getcwd()
--   for i, content in pairs(contents) do
--     local flnm = content.file
--     if string.sub(flnm, 1, string.len(cwd)) == cwd then
--       flnm = require('plenary')
--     end
--   end
-- end, {nargs="*"})

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
