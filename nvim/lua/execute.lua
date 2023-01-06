function SetEnvVariable(name, value)
	vim.cmd(":let "..name.."="..value)
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
	for k, v in ipairs(envs) do
		SetEnvVariable(k, v)
	end
end
