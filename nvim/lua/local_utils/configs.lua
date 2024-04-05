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
