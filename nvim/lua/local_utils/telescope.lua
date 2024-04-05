require('local_utils.configs')

function LoadTelescopeConfig()
  local telescopeConfig = LoadConfig('telescope')
  if not telescopeConfig then
    telescopeConfig = {ignore={}}
  end
  return telescopeConfig
end

function GetTelescopeConfig(name)
  local telescopeConfig = LoadTelescopeConfig()
  return telescopeConfig[name]
end

function GetTelescopeIgnoreConfig()
  local telescopeConfig = GetTelescopeConfig('ignore')
  table.insert(telescopeConfig, '%.git[/\\]')
  return telescopeConfig
end
