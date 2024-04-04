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

local telescopeWorkspaceFolders = get_config("workspace-folders")
if not telescopeWorkspaceFolders then
  telescopeWorkspaceFolders = {}
end
telescopeWorkspaceFolders['current'] = vim.fn.getcwd()

telescopeWorkspaceFoldersKeys = {}

for key, val in pairs(telescopeWorkspaceFolders) do
  table.insert(telescopeWorkspaceFoldersKeys, key)
end

local telescopeIgnore = get_config("ignore")
if not telescopeIgnore then telescopeIgnore = {} end

table.insert(telescopeIgnore, '%.git[/\\]')

local fb_actions = require("telescope").extensions.file_browser.actions
local fb_utils = require("telescope._extensions.file_browser.utils")

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
			-- theme = "dropdown",
			-- disable netrw and use telescope-file-browser in its place
			hijack_netrw = true,
      no_ignore = true,
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" },
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
					end,
          ["<C-r>"] = function(d)
            local selected = fb_utils.get_selected_files(d, false)
            local folders = {}
            for _, s in ipairs(selected) do
              table.insert(folders, s:absolute())
            end
            builtin.live_grep({
              search_dirs = folders,
            })
          end,
          ["<C-A-r>"] = function(d)
            local selected = fb_utils.get_selected_files(d, false)
            local folders = {}
            for _, s in ipairs(selected) do
              table.insert(folders, s:absolute())
            end
            vim.ui.input({
              prompt = 'File Type',
              default = ''
            }, function (input)
              builtin.live_grep({
                search_dirs = folders,
                type_filter = input
              })
            end)
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
		hidden = true,
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = 'top'
    }
	})
end)
vim.keymap.set('n', ';b', builtin.buffers)
vim.keymap.set('n', '<C-a>', builtin.buffers)
vim.keymap.set('n', ';ch', builtin.command_history)
vim.keymap.set('n', ';cl', builtin.commands)
vim.keymap.set('n', ';cbff', builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', ';cbt', builtin.current_buffer_tags)

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
vim.keymap.set('n', 'sf', '<Cmd>Telescope file_browser path=%:p:h<CR>')
vim.keymap.set('n', 'gs', '<Cmd>Telescope grep_string<CR>')
vim.keymap.set("n", "<A-f>", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = true,
    no_ignore = true,
		hidden = true,
		grouped = true,
		initial_mode = "insert",
    sorting_strategy = "ascending",
		layout_config = { prompt_position = "top" }
	})
end)

local customSearchFileG = ""

local function searchFileSpecificFolder()
  vim.ui.input({
    prompt = "Location :",
    default = customSearchFileG,
    completion = "file"
  }, function (input)
    --if input == '' then
      --input = customSearchFile
    --end
    customSearchFileG = input
    builtin.find_files({
      no_ignore = false,
      hidden = true,
      cwd = customSearchFileG
    })
  end)
end

-- telescope.load_extension("ui-select")

local function searchFileSpecificFolderSelect()
  vim.ui.select(telescopeWorkspaceFoldersKeys, {
    prompt = "Project :",
  }, function (input)
    local customSearchFile = telescopeWorkspaceFolders[input]
    builtin.find_files({
      no_ignore = false,
      hidden = true,
      cwd = customSearchFile,
      respect_gitignore = true,
      grouped = true,
      initial_mode = "normal",
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" }
    })
  end)
end

vim.keymap.set('n', ';wf', function()
  searchFileSpecificFolderSelect()
end)


local function navigateFileWorkspace()
  vim.ui.select(telescopeWorkspaceFoldersKeys, {
    prompt = "Project :"
  },function (input)
    local customSearchFile = telescopeWorkspaceFolders[input]
    telescope.extensions.file_browser.file_browser({
      path = customSearchFile,
    })
  end)
end

vim.keymap.set('n', "<A-w>", function()
  navigateFileWorkspace()
end)

vim.keymap.set('n', "<A-g>", function()
  local search_term = ""
  local search_location = ""
  vim.ui.select(telescopeWorkspaceFoldersKeys, {
    prompt = "Project :"
  }, function(input)
    search_location = telescopeWorkspaceFolders[input]
    vim.ui.input({prompt = "Location :", completion = "file"}, function(input1)
      search_location = search_location .. '/' .. input1
      vim.ui.input({prompt = "Search :"}, function(input2)
        search_term = input2
        local request_status, result = pcall(vim.cmd, "vim " .. search_term .. ' ' .. search_location)
        print(result)
      end)
    end)
  end)
end)

