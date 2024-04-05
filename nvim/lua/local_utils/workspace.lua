require('local_utils.configs')

function LoadWorkspace()
  local workspaceconfigs = LoadConfig('workspace')
  if not workspaceconfigs then
    workspaceconfigs = { }
  end
  workspaceconfigs['current'] = vim.fn.getcwd()
  return workspaceconfigs
end

local function _addToWorkspace(name, path)
  local workspaceconfigs = LoadConfig('workspace')
  if not workspaceconfigs then
    workspaceconfigs = {current = vim.fn.getcwd()}
  end
  workspaceconfigs[name] = path
  SaveConfig('workspace', workspaceconfigs)
  return workspaceconfigs
end

function GetWorkspace()
  local workspaceconfigs = LoadWorkspace()
  local workspacekey = {}
  for key, _ in pairs(workspaceconfigs) do
    table.insert(workspacekey, key)
  end
  return {keys = workspacekey, map = workspaceconfigs}
end

function AddToWorkspace(name, path)
  local workspaceconfigs = _addToWorkspace(name, path)
  local workspacekey = {}
  for key, _ in pairs(workspaceconfigs) do
    table.insert(workspacekey, key)
  end
  return {keys = workspacekey, map = workspaceconfigs}
end
