local uv = vim.loop
local log = require('dap.log').create_logger('local-dap.log')
local utils = require('dap.utils')
local server_executable = nil
local repl = require('dap.repl')

function GetFreePort()
  local tcp = assert(uv.new_tcp(), "Must be able to create tcp client")
  tcp:bind('127.0.0.1', 0)
  local port = tcp:getsockname().port
  tcp:shutdown()
  tcp:close()
  return port
end

function KillServerExecutable()
  if server_executable then
    if vim.fn.has("win32") == 1 then
      server_executable:kill("sighup")
    else
      server_executable:kill("sigterm")
    end
  end
end

function SpawnServerExecutable(executable)
  local cmd = assert(executable.command, "executable of server adapter must have a `command` property")
  log.debug("Starting debug adapter server executable", executable)
  local stdout = assert(uv.new_pipe(false), "Must be able to create pipe")
  local stderr = assert(uv.new_pipe(false), "Must be able to create pipe")
  print(vim.json.encode(executable.env))
  local opts = {
    stdio = {nil, stdout, stderr},
    args = executable.args or {},
    detached = utils.if_nil(executable.detached, true),
    cwd = executable.cwd,
    env = executable.env,
  }
  local handle, pid_or_err
  handle, pid_or_err = uv.spawn(cmd, opts, function(code)
    if handle then
      handle:close()
    end
    if code ~= 0 then
      utils.notify(cmd .. " exited with code " .. code, vim.log.levels.WARN)
    end
  end)
  if not handle then
    stdout:close()
    stderr:close()
    error(pid_or_err)
  end

  local read_output = function(stream, pipe)
    return function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          if repl then
            repl.append('[debug-adapter ' .. stream .. '] ' .. chunk)
          end
        end)
      else
        pipe:close()
      end
    end
  end
  stderr:read_start(read_output('stderr', stderr))
  stdout:read_start(read_output('stdout', stdout))

  server_executable = handle
end


