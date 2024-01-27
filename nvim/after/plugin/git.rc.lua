local status, gitsigns = pcall(require, 'gitsigns')
if (not status) then return end

gitsigns.setup {}

local status, git = pcall(require, "git")
if (not status) then return end

git.setup({
  winbar = true,
	keymaps = {
		blame = ";gb",
		quit_blame = "q",
		browse=";go",
		blame_commit="<CR>",
		diff=";gd",
	}
})
