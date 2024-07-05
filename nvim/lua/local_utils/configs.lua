function LoadConfig(configname)
  local file = io.open('.' .. configname .. '.json')
  local content = nil
  if file then
    local c = file:read("*a")
    content = vim.json.decode(c)
    file:close()
  end
  return content
end

function GetConfig(config_name, name)
  local value = nil
  local config = LoadConfig(config_name)
  if config then
    value = config[name]
  end
  return value
end

function SaveConfig(config_name, content)
  local file = io.open('.' .. config_name .. '.json', 'w')
  local json_content = vim.json.encode(content)
  if file then
    file:write(json_content)
    file:close()
  end
end

function PathJoin(files)
  local is_windows = vim.fn.has('win32') or vim.fn.has('win64')
  local join_char = '/'
  if is_windows then
    join_char = '\\'
  end
  return table.concat(files, join_char)
end

DebugAdapterLocation = PathJoin({"C:", "debugadapter"})
-- UserHome = PathJoin({"C:", "Users", "tsior"})
UserHome = vim.env.HOME

DebugPaths = {}

function SetDefaultLocation()
  local is_windows = vim.fn.has('win32') or vim.fn.has('win64')
  if vim.env.VIM_DEBUG_ADAPTERS then
    DebugAdapterLocation = vim.env.VIM_DEBUG_ADAPTERS
  end
  local cppdbg_debugger = {UserHome, ".vscode", "extensions", "ms-vscode.cpptools-1.18.5-win32-x64", "ms-vscode.cpptools-1.18.5-win32-x64", "debugAdapters", "bin"}
  if is_windows then
    table.insert(cppdbg_debugger, #cppdbg_debugger + 1, "OpenDebugAD7.exe")
  else
    table.insert(cppdbg_debugger, #cppdbg_debugger + 1, "OpenDebugAD7")
  end
  DebugPaths['cppdbg'] = PathJoin(cppdbg_debugger)
  DebugPaths['vsdbg'] = PathJoin({UserHome, '.vscode', 'extensions', 'ms-vscode.cpptools-1.18.5-win32-x64', 'debugAdapters', 'vsdbg', 'bin', 'vsdbg.exe'})
  DebugPaths['firefox'] = PathJoin({DebugAdapterLocation, 'vscode-firefox-debug', 'dist', 'adapter.bundle.js'})
  DebugPaths['chrome'] = PathJoin({DebugAdapterLocation, 'vscode-chrome-debug', 'out', 'src', 'chromeDebug.js'})
  DebugPaths['node'] = PathJoin({DebugAdapterLocation, 'vscode-node-debug2', 'out', 'src', 'nodeDebug.js'})
end
