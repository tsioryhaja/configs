local uv = vim.loop

local function getParams(config)
  local result = {}
  if config.type == "launch" then
    if config.program then
      table.insert(result, config.program)
    end
    if config.module then
      table.insert(result, '-m')
      table.insert(result, config.module)
    end
    if config.args then
      for _, v in pairs(config.args) do
        table.insert(result, v)
      end
    end
  elseif config.type == "server" then
    if config.localDebugpyLauncherCommand then
      result = config.localDebugpyLauncherCommand
    end
  end
  return result
end

function DebugpySocketsHandler(session, body)
  -- print(session.config.program)
  -- print(vim.json.encode(body))
  local sockets = body.sockets
  if #sockets > 0 then
    local port = 0
    for _, value in pairs(sockets) do
      print(vim.json.encode(value))
      if value.port > port then
        port = value.port
      end
    end
    if port > 0 then
      local opts = {
        "C:\\Users\\tsiory_re\\.vscode\\extensions\\ms-python.debugpy-2024.6.0-win32-x64\\bundled\\libs\\debugpy\\launcher",
        -- "-m",
        -- "debugpy.launcher",
        tostring(port),
        "--",
      }
      local newargs = getParams(session.config)
      for _, v in pairs(newargs) do
        table.insert(opts, v)
      end
      print(port)
      uv.spawn('python', {args = opts})
    end
  end
end

