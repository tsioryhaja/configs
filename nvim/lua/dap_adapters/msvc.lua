local dap = require('dap')

local uv = vim.loop

local utils = require('dap.utils')

local rpc = require('dap.rpc')

local function send_payload(client, payload)
  local msg = rpc.msg_with_content_length(vim.json.encode(payload))
  client.write(msg)
end

function RunHandshake(self, request_payload)
  local signResult = io.popen('node C:\\debugadapter\\vsdbgsignature\\sign.js ' .. request_payload.arguments.value)
  if signResult == nil then
    utils.notify('error while signing handshake', vim.log.levels.ERROR)
    return
  end
  local signature = signResult:read("*a")
  signature = string.gsub(signature, '\n', '')
  local response = {
    type = "response",
    seq = 0,
    command = "handshake",
    request_seq = request_payload.seq,
    success = true,
    body = {
      signature = signature
    }
  }
  send_payload(self.client, response)
end

function RunInTerminal(lsession, request)
  local body = request.arguments
  -- local settings = dap.defaults[lsession.config.type]
  local terminal = {
    command = "cmd.exe",
    args = {'/c'}
  }
  local full_args = {}
  vim.list_extend(full_args, terminal.args)
  vim.list_extend(full_args, body.args)
  local f = io.open('C:\\Projects\\val2.json', 'r')
  local envs = vim.json.decode(f:read())
  f:close()
  local opts = {
    args = full_args,
    detached = true,
    verbatim = true,
    env = envs,
  }
  handle, pid = uv.spawn(terminal.command, opts, function(code)
    if handle then
      handle:close()
    end
    if code ~= 0 then
      utils.notify(string.format('Terminal exited %d running %s %s', code, terminal.command, table.concat(full_args, ' ')), vim.log.levels.ERROR)
    end
  end)
  lsession:response(request, {
    success = handle ~= nil;
    body = { processId = pid; };
  })
end
