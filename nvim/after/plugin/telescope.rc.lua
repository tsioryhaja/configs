local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

local function telescope_buffer_dir()
	return vim.fn.expand('%:p:h')
end

load_config = function()
	file = io.open('.telescope.json','r')
	content = nil
	if file then
		c = file:read('*a')
		content = vim.json.decode(c)
	end
	return content
end

get_config = function(name)
	value = nil
	config = load_config()
	if config then
		value = config[name]
	end
	return value
end

local telescopeIgnore = get_config("ignore")
if not telescopeIgnore then telescopeIgnore = {} end

table.insert(telescopeIgnore, '%.git[/\\]')

local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup {
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close

			},
		},
		file_ignore_patterns = telescopeIgnore
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			-- disable netrw and use telescope-file-browser in its place
			hijack_netrw = true,
      layout_config = {
        height = 40
      },
			mappings = {
				["i"] = {
					["<C-w>"] = function() vim.cmd('normal vbd') end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["<C-s>"] = actions.select_vertical,
					["<C-n>"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd('startinsert')
					end
				},
			},
		},
	},
}

telescope.load_extension("file_browser")
telescope.load_extension("dap")

vim.keymap.set('n', ';f',
function()
	builtin.find_files({
		no_ignore = false,
		hidden = true
	})
end)

vim.keymap.set('n', ';r', function()
	builtin.live_grep()
end)
vim.keymap.set('n', '\\\\', function()
	builtin.buffers()
end)
vim.keymap.set('n', ';t', function()
	builtin.help_tags()
end)
vim.keymap.set('n', ';;', function()
	builtin.resume()
end)
vim.keymap.set('n', ';e', function()
	builtin.diagnostics()
end)
vim.keymap.set('n', '<A-f>', '<Cmd>Telescope file_browser path=%:p:h<CR>')
vim.keymap.set('n', 'gs', '<Cmd>Telescope grep_string<CR>')
vim.keymap.set("n", "sf", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = true,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 }
	})
end)
