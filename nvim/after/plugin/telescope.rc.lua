local status, telescope = pcall(require, "telescope")
if (not status) then return end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local action_state = require('telescope.actions.state')
local utils = require('telescope.utils')
require('local_utils.telescope')
require('local_utils.workspace')

local function telescope_buffer_dir()
	return vim.fn.expand('%:p:h')
end


local fb_actions = require("telescope").extensions.file_browser.actions
local layout_actions = require('telescope.actions.layout')
local fb_utils = require("telescope._extensions.file_browser.utils")

local telescopeIgnore = GetTelescopeIgnoreConfig()

telescope.setup {
	defaults = {
		mappings = {
      i = {
        ["<A-p>"] = layout_actions.toggle_preview,
      },
			n = {
				["q"] = actions.close,
        ["<A-p>"] = layout_actions.toggle_preview,
        [";r"] = function (prompt_bufnr)
          local cwd = action_state.get_current_picker(prompt_bufnr).cwd
          local selection = action_state.get_selected_entry()
          if selection == nil then
            utils.__warn_no_selection "no selection"
            return
          end
          if selection.status:sub(2) == " " then
            utils.__warn_no_selection "staged modification"
          else
            utils.get_os_command_output({ "git", "checkout", "--", selection.value }, cwd)
            action_state.get_current_picker(prompt_bufnr):find()
          end
        end
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
          end,
          ['<C-w>'] = function(d)
            local entry = action_state.get_selected_entry()
            vim.ui.input({prompt = "Project name"}, function (input)
              AddToWorkspace(input, entry.path)
            end)
          end
				},
			},
		},
	},
}

telescope.load_extension("file_browser")
-- telescope.load_extension("dap")

vim.keymap.set('n', '<leader>f',
function()
  -- local workspace = GetWorkspace()
  -- local workspace_folders = {}
  -- for _, val in pairs(workspace.map) do
  --   table.insert(workspace_folders, val)
  -- end
	builtin.find_files({
		no_ignore = false,
		hidden = true,
    -- search_dirs = workspace_folders,
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = 'top'
    }
	})
end)
vim.keymap.set('n', '<leader>b', ':buffers t<CR>')
vim.keymap.set('n', '<C-a>', function ()
  builtin.buffers({sort_mru = true})
end)
vim.keymap.set('n', '<leader>ch', builtin.command_history)
vim.keymap.set('n', '<leader>cl', builtin.commands)
vim.keymap.set('n', '<leader>cbff', builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>cbt', builtin.current_buffer_tags)


vim.keymap.set('n', '<leader>r', function()
  local workspace = GetWorkspace()
  local workspace_folders = {}
  for _, val in pairs(workspace.map) do
    table.insert(workspace_folders, val)
  end
	builtin.live_grep({
    search_dirs = workspace_folders
  })
end)
vim.keymap.set('n', '\\\\', function()
	builtin.buffers()
end)
vim.keymap.set('n', '<leader>t', function()
	builtin.help_tags()
end)
vim.keymap.set('n', '<leader>;', function()
	builtin.resume()
end)
vim.keymap.set('n', '<leader>e', function()
	builtin.diagnostics()
end)
vim.keymap.set('n', 'sf', '<Cmd>Telescope file_browser path=%:p:h<CR>')
vim.keymap.set('n', 'gs', '<Cmd>Telescope grep_string<CR>')
vim.keymap.set('n', '<leader>ss', builtin.lsp_workspace_symbols)
vim.keymap.set('n', '<leader>sd', builtin.lsp_document_symbols)
-- vim.keymap.set('n', '<leader>wss', function()
--   vim.ui.input({prompt = 'Symbol'}, function(input)
--     builtin.lsp_workspace_symbols({query = input})
--   end)
-- end)
vim.keymap.set('n', '<leader>wss', builtin.lsp_dynamic_workspace_symbols)
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


-- telescope.load_extension("ui-select")

local function searchFileSpecificFolderSelect()
  local workspace = GetWorkspace()
  vim.ui.select(workspace.keys, {
    prompt = "Project :",
  }, function (input)
    local customSearchFile = workspace.map[input]
    builtin.find_files({
      no_ignore = false,
      hidden = true,
      cwd = customSearchFile,
      -- search_dirs = workspace_folders,
      respect_gitignore = true,
      grouped = true,
      initial_mode = "normal",
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" }
    })
  end)
end

vim.keymap.set('n', '<leader>wf', function()
  searchFileSpecificFolderSelect()
end)


local function navigateFileWorkspace()
  local workspace = GetWorkspace()
  vim.ui.select(workspace.keys, {
    prompt = "Project :"
  },function (input)
    local customSearchFile = workspace.map[input]
    telescope.extensions.file_browser.file_browser({
      path = customSearchFile,
    })
  end)
end

vim.keymap.set('n', "<A-w>", function()
  navigateFileWorkspace()
end)

vim.api.nvim_create_user_command('GitStatus', function()
  -- GetGitStatus(true)
  builtin.git_status()
end, {})

vim.keymap.set('n', "<A-g>", function()
  local workspace = GetWorkspace()
  local search_term = ""
  local search_location = ""
  vim.ui.select(workspace.keys, {
    prompt = "Project :"
  }, function(input)
    search_location = workspace.map[input]
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

