local status, dressing = pcall(require, 'dressing')
if  (not status) then return end

dressing.setup({
	input = {
		enabled = true,
		default_prompt = "Input:",
		prompt_align = "center",
		insert_only = false,
		start_in_insert = false,
		border = 'rounded',
		relative = "cursor",
		prefer_width = 40,
		win_options = {
			wrap = false,
      winhighlight = "NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder,FloatTitle:TelescopePromptTitle",
		},
		mappings = {
			n = {
				["<Esc>"] = "Close",
				["<CR>"] = "Confirm"
			},
			i = {
				["<C-c>"] = "Close",
				["<CR>"] = "Confirm",
				["<Up>"] = "HistoryPrev",
				["<Down>"] = "HistoryNext",
			}
		}
	},
	select = {
		enabled = true,
	}
})
