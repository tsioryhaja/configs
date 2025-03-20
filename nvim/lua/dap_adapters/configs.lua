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
    configuration.name = name
    if not dap.configurations[config.language] then
      dap.configurations[config.language] = {}
    end
    if adapter then
      local adapter_name = 'custom_adapter'..i
      dap.adapters[adapter_name] = adapter
      configuration.type = adapter_name
    end
		table.insert(dap.configurations[config.language], 1, configuration)
	end
end
