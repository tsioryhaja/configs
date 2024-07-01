local status, lualine = pcall(require, "lualine")
if (not status) then return end

local colors = {
  white = "#f0f0f0",
  dark_grey = "#252526",
  light_grey = "#3b3b3b",
  green  = '#c3e88d',
  purple = '#c792ea',
  red   = '#f07178',
}

local theme = require('lualine.themes.gruvbox_dark')
theme.normal.b.bg = nil
theme.normal.b.fg = nil
theme.normal.c.bg = nil
theme.normal.c.fg = nil

theme.visual.b.bg = nil
theme.visual.b.fg = nil
theme.visual.c.bg = nil
theme.visual.c.fg = nil

theme.replace.b.bg = nil
theme.replace.b.fg = nil
theme.replace.c.bg = nil
theme.replace.c.fg = nil

theme.insert.b.bg = nil
theme.insert.b.fg = nil
theme.insert.c.bg = nil
theme.insert.c.fg = nil

theme.command.b.bg = nil
theme.command.b.fg = nil
theme.command.c.bg = nil
theme.command.c.fg = nil

theme.inactive.b.bg = nil
theme.inactive.b.fg = nil
theme.inactive.c.bg = nil
theme.inactive.c.fg = nil

theme.normal.a.bg = colors.white
theme.normal.a.fg = colors.dark_grey

lualine.setup {
	options = {
		icons_enabled = true,
		theme = theme,
		-- section_separators = { left = '', right = '' },
		-- component_separators = { right = '▏', left = '▕' },
		component_separators = { right = '│', left = '│' },
		-- section_separators = { left = '', right = '' },
    section_separators = '';
		-- component_separator = { left = '\\', right = '/' },
		disabled_filetypes = {}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff' },
		lualine_c = { {
			'filename',
			file_status = true,
			path = 1 -- 0 just filename, 1 relative path, 2 absolute path
		} },
		lualine_x = {
			{
				'diagnostics',
				sources = { "nvim_diagnostic" },
				symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
			},
			'encoding',
			'filetype'
		},
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { {
			'filename',
			file_status = true,
			path = 1
		} },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	extensions = { 'fugitive' }
}
