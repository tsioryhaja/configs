local status, gitsigns = pcall(require, 'gitsigns')
if (not status) then return end

gitsigns.setup {}

local status, git = pcall(require, "git")
if (not status) then return end

git.setup({
  winbar = true,
	keymaps = {
		blame = "<leader>gb",
		quit_blame = "q",
		browse="<leader>go",
		blame_commit="<CR>",
		diff="<leader>gd",
	}
})

-- local st, vgit = pcall(require, 'vgit')
--
-- if st then
--   vgit.setup()
-- end
