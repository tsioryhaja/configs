local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

-- bufferline.setup({
-- 	options = {
-- 		mode = "tabs",
-- 		separator_style = 'thin',
-- 		always_show_bufferline = true,
-- 		show_buffer_close_icons = false,
-- 		show_close_icon = true,
-- 		color_iconss = true,
--     diagnostics = "nvim_lsp",
--     diagnostics_indicator = function (count, level, errors, ctx)
--       local error = level:match("error") and "  " .. count or ""
--       local warning = level:match("warning") and "  " .. count or ""
--       return warning .. " " .. error
--     end
-- 	},
-- 	-- highlights = {
-- 	-- 	separator = {
-- 	-- 		fg = '#5d5d5d',
-- 	-- 		bg = '#666666',
-- 	-- 	},
-- 	-- 	background = {
-- 	-- 		fg = '#fdf6e3',
-- 	-- 		bg = '#666666'
-- 	-- 	},
-- 	-- 	buffer_selected = {
-- 	-- 		fg = '#fdf6e3',
-- 	-- 		bold = true,
-- 	-- 	},
-- 	-- 	duplicate = {
-- 	-- 		bg = '#666666'
-- 	-- 	},
-- 	-- 	fill = {
-- 	-- 		bg = '#5d5d5d'
-- 	-- 	},
--  --    modified = {
--  --      bg = "#666666"
--  --    },
--  --    error = {
--  --      fg = "#f00a2c",
--  --      bg = "#666666"
--  --    },
--  --    error_visible = {
--  --      fg = "#f00a2c",
--  --      bg = "#666666"
--  --    },
--  --    error_diagnostic = {
--  --      fg = "#f00a2c",
--  --      bg = "#666666"
--  --    },
--  --    warning = {
--  --      fg = "#f5fc9f",
--  --      bg = "#666666"
--  --    },
--  --    warning_visible = {
--  --      fg = "#f5fc9f",
--  --      bg = "#666666"
--  --    },
--  --    warning_diagnostic = {
--  --      fg = "#f5fc9f",
--  --      bg = "#666666"
--  --    },
--  --    info = {
--  --      fg = "#215bb8",
--  --      bg = "#666666"
--  --    },
--  --    info_visible = {
--  --      fg = "#215bb8",
--  --      bg = "#666666"
--  --    },
--  --    info_diagnostic = {
--  --      fg = "#215bb8",
--  --      bg = "#666666"
--  --    },
--  --    hint = {
--  --      fg = "#215bb8",
--  --      bg = "#666666"
--  --    },
--  --    hint_visible = {
--  --      fg = "#215bb8",
--  --      bg = "#666666"
--  --    },
--  --    hint_diagnostic = {
--  --      fg = "#215bb8",
--  --      bg = "#666666"
--  --    },
-- 	-- },
-- })

function MyTabLine()
  local s = ''
  for i = 0, vim.fn.tabpagenr('$') do
    if (i + 1) == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end
    if (i + 1) <= vim.fn.tabpagenr('$') then
      -- s = s .. "%" .. (i + 1) .."t"
      -- s = s .. ' %{My} '
    end
  end
  return s
end

vim.o.tabline = "%!v:lua.MyTabLine()"

-- vim.keymap.set('n', '<A-l>', '<Cmd>BufferLineCycleNext<CR>')
-- vim.keymap.set('n', '<A-h>', '<Cmd>BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<A-l>', '<Cmd>tabp<CR>')
vim.keymap.set('n', '<A-h>', '<Cmd>tabn<CR>')
vim.keymap.set('n', '<A-j>', '<Cmd>m .+1<CR>')
vim.keymap.set('n', '<A-k>', '<Cmd>m .-2<CR>')
vim.keymap.set('n', '<C-n>', '<Cmd>set rnu!<CR>')
vim.keymap.set('n', '<C-A-h>', '<Cmd>tabm -1<CR>')
vim.keymap.set('n', '<C-A-l>', '<Cmd>tabm +1<CR>')


local function get_all_tabs()
  local tabs = vim.fn.gettabinfo()
  local result_table = {}
  local json_buffers = {}
  local tabs_lists = {}
  for k, v in pairs(tabs) do
    local buffers = {}
    for k1, wn in pairs(v['windows']) do
      buf = vim.api.nvim_win_get_buf(wn)
      name = (buf and vim.api.nvim_buf_is_valid(buf)) and vim.api.nvim_buf_get_name(buf)
      if not name or name == "" then name = "[No Name]" end
      table.insert(result_table, name)
      print(vim.bo[buf].buftype)
      --table.insert(json_buffers, vim.fn.getbufinfo(buf))
      table.insert(json_buffers, vim.fn.getwininfo(wn))
      --table.insert(json_buffers, {vim.bo[buf].buftype, vim.bo[buf].filetype, vim.bo[buf]})
    end
    table.insert(tabs_lists, buffers)
  end
  local file = io.open('tttt.json', 'w')
  if file then
    file:write(vim.json.encode(json_buffers))
    file:close()
  end
  --vim.ui.select(json_buffers, {prompt = 'This is data shit'}, function() print('shit') end)
end

vim.keymap.set('n', '<A-a>', function() get_all_tabs() end)
