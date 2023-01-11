local uv = vim.loop
local api = vim.api


local function new_win()
	api.nvim_command('below split')
	local win  = api.nvim_get_current_win()
	return win
end

local function new_buf()
	local buf = api.nvim_create_buf(true, true)
	api.nvim_buf_set_option(buf, 'buftype', 'prompt')
	api.nvim_buf_set_option(buf, 'filetype', 'dap-repl')
	return buf
end

function ExecuteCommand()
	local buf = new_buf()
	local win = new_win()
	api.nvim_win_set_buf(win, buf)
	local command = "cmake"
	local args = {"-G", 'MinGW Makefiles', "."}
	local stdin = uv.new_pipe(true)
	local stdout = uv.new_pipe(false)
	local stderr = uv.new_pipe(false)
	local handle
	local pid_or_err
	local function onexit()
		stdout:close()
		stderr:close()
		if handle and not handle:is_closing() then
			handle:close(function ()
				handle = nil
			end)
		end
	end
	local spawn_opts = {
		args = args;
		stdio = {stdin, stdout, stderr};
	}
	handle, pid_or_err = uv.spawn(command, spawn_opts, onexit)
	--- print('process opened', handle, pid_or_err)
	stdout:read_start(vim.schedule_wrap(function(err, body)
		if body then
			local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
			for k, b in pairs(vim.split(body, '\n')) do
				table.insert(lines, b)
			end
			api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		end

		--print(err, body)
	end))
end
