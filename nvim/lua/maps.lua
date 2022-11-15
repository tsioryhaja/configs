vim.keymap.set('n', 'i', '<Up>')
vim.keymap.set('n', 'k', '<Down>')
vim.keymap.set('n', 'j', '<Left>')
vim.keymap.set('n', 'l', '<Right>')

vim.keymap.set('n', 'h', '<Insert>')

vim.keymap.set('v', 'i', '<Up>')
vim.keymap.set('v', 'k', '<Down>')
vim.keymap.set('v', 'j', '<left>')
vim.keymap.set('v', 'l', '<Right>')

vim.cmd(':vnoremap h i')

local api = vim.api

local function get_wins_buf(wins)
	local wins_buffer_names = {}
	for i, win_key in ipairs(wins) do
		local conf = api.nvim_win_get_position(win_key)
		print(vim.json.encode(conf))
		local buf_id = api.nvim_win_get_buf(win_key)
		local buf_name = api.nvim_buf_get_name(buf_id)
		table.insert(wins_buffer_names, buf_name)
	end
	return wins_buffer_names
end

local function write_content(tab_id, buffer_names)
	local file = io.open('.session.txt', 'a')
	if file then
		file:write(tab_id)
		file:write("\n")
		for i, buffer_name in ipairs(buffer_names) do
			file:write(buffer_name)
			file:write("\n")
		end
	end
	io.close(file)
end

local function save_current_tabs()
	local tabs = api.nvim_list_tabpages()
	for i, tab_key in ipairs(tabs) do
		print(tab_key)
		local wins = api.nvim_tabpage_list_wins(tab_key)
		local buffers_name = get_wins_buf(wins)
		write_content(tab_key, buffers_name)
	end
end

vim.api.nvim_create_user_command('SaveAllCurrent', save_current_tabs, {})
