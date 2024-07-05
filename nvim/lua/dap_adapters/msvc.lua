local dap = require('dap')
require('local_utils.configs')

local uv = vim.loop

local utils = require('dap.utils')

local rpc = require('dap.rpc')

local function send_payload(client, payload)
  local msg = rpc.msg_with_content_length(vim.json.encode(payload))
  client.write(msg)
end

function RunHandshake(self, request_payload)
  local sign_file_location = PathJoin({DebugAdapterLocation, "vsdbgsignature", "sign.js"})
  local signResult = io.popen('node ' .. sign_file_location .. ' ' .. request_payload.arguments.value)
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

