local status, lualine = pcall(require, "lualine")
if (not status) then return end

lualine.setup {
	options = {
		icons_enabled = true,
		theme = 'material',
		-- section_separators = { left = '', right = '' },
		-- component_separator = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		component_separator = { left = '\\', right = '/' },
		disabled_filetypes = {}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch' },
		lualine_c = { {
			'filename',
			file_status = true,
			path = 1 -- 0 just filename, 1 relative path, 2 absolute path
		} },
		lualine_x = {
			{
				'diagnostic',
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
