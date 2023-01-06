local function LoadDapAdapters()
	local file = io.open('.dap-adapters.json', 'r')
	local content = nil
	if file then
		local c = file:read('*a')
		content = vim.json.decode(c)
	end
	return content
end

function GetConfigs(dap)
	local configs = LoadDapAdapters()
	if not configs then
		return
	end
	for i, config in ipairs(configs) do
		local adapter = config.adapter
		local configuration = config.configuration
		local name = config.name
		local adapter_name = 'custom_adapter'..i
		dap.adapters[adapter_name] = adapter
		configuration.type = adapter_name
		dap.configurations[name] = configuration
	end
end
