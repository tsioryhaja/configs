local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
	options = {
		mode = "tabs",
		separator_style = 'thin',
		always_show_bufferline = true,
		show_buffer_close_icons = false,
		show_close_icon = true,
		color_iconss = true,
	},
	highlights = {
		separator = {
			fg = '#5d5d5d',
			bg = '#666666',
		},
		separator_selected = {
			fg = '#5d5d5d',
		},
		background = {
			fg = '#fdf6e3',
			bg = '#666666'
		},
		buffer_selected = {
			fg = '#fdf6e3',
			bold = true,
		},
		duplicate = {
			bg = '#666666'
		},
		fill = {
			bg = '#5d5d5d'
		}
	},
})

vim.keymap.set('n', '<A-l>', '<Cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<A-j>', '<Cmd>BufferLineCyclePrev<CR>')
