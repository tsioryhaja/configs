function SetEnvVariable(name, value)
	value = '"'..value..'"'
  value = value.gsub('"', '\\n')
	vim.cmd(":let $"..name.."="..value)
end

function GetConfig(configName)
	local file = io.open('.'..configName..'.json', 'r')
	local content = {}
	if file then
		local c = file:read('*a')
		content = vim.json.decode(c)
	end
	return content
end

function SetEnvs()
	local envs = GetConfig('envs')
	for k, v in pairs(envs) do
		SetEnvVariable(k, v)
	end
end

function LoadSetOfEnv(name)
  local envs = GetConfig(name..'envs')
	for k, v in pairs(envs) do
		SetEnvVariable(k, v)
	end
end
