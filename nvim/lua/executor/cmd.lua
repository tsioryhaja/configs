require('execute')

local tasks = require("executor.tasks")

vim.keymap.set('n', '<leader>et', function ()
  local config = GetConfig('tasks')
  local config_names = {}
  for i, _ in pairs(config) do
    table.insert(config_names, i)
  end
  vim.ui.select(config_names, {
    prompt = "Task :"
  }, function (input)
    local to_launch = config[input]
    tasks.cmd(to_launch)
  end
  )
end)
