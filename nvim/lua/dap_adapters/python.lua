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
    -- if config.localDebugpyLauncherCommand then
    --   result = config.localDebugpyLauncherCommand
    -- end
  end
  return result
end

local function table_contains(_table, _value)
  local found = false
  for _, v in pairs(_table) do
    found = found or v == _value
  end
  return found
end

function DebugpySocketsHandler(session, body)
  -- print(session.config.program)
  -- print(vim.json.encode(body))
  local sockets = body.sockets
  if #sockets > 0 then
    local port = 0
    for _, value in pairs(sockets) do
      if value.port > port and value.internal == false then
        -- print(vim.json.encode(value))
        port = value.port
      end
    end
    if not session.debugpy_connected_ports then
      session.debugpy_connected_ports = {}
    end
    if port > 0 and not table_contains(session.debugpy_connected_ports, port) then
      local opts = {
        "C:\\Users\\tsiory_re\\.vscode\\extensions\\ms-python.debugpy-2024.6.0-win32-x64\\bundled\\libs\\debugpy\\launcher",
        -- "-m",
        -- "debugpy.launcher",
        tostring(port),
        "--",
      }
      -- local newargs = getParams(session.config)
      -- for _, v in pairs(newargs) do
      --   table.insert(opts, v)
      -- end
      -- print(port)
      -- print(vim.json.encode(opts))
      table.insert(session.debugpy_connected_ports, port)
      uv.spawn('python', {args = opts})
    end
  end
end

