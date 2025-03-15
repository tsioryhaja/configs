local repl = require('dap.repl')

local ReplLog = {}

function ReplLog:write(chunk)
  if chunk then
    vim.schedule(function ()
      repl.append(chunk)
    end)
  end
end

function ReplLog:close()
end

function ReplLog:remove()
end

function MakeReplLogger()
  local l = {}
  local logger = setmetatable(l, {__index = ReplLog})
  return logger
end
