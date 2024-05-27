-- local status, kanagawa = pcall(require, "kanagawa")
-- if (not status) then
--   return
-- end
--
-- kanagawa.setup{
--   -- theme = "wave",
--   -- theme = "dragon",
--   -- theme = "lotus",
--   colors = {
--     theme = {
--       all = {
--         ui = {
--           bg_gutter = "none"
--         }
--       }
--     }
--   }
-- }
--
-- vim.cmd":colorscheme kanagawa-wave"
-- vim.cmd":colorscheme kanagawa-dragon"
-- vim.cmd":colorscheme kanagawa-lotus"

-- local ubuntuSelect = '#77216F'
-- local ubuntuSelect = '#5E2750'
local greySelect = 'grey40'
-- local darkGrey = '#333333'


vim.cmd':hi Pmenu guibg=none'
vim.cmd(':hi CursorLine guibg='..greySelect)
vim.cmd(':hi TelescopePreviewLine guibg='..greySelect)
vim.cmd(':hi TelescopeSelection guibg='..greySelect)
vim.cmd(':hi Visual guibg='..greySelect)

-- ubuntu colorscheme origin
-- https://design.ubuntu.com/brand/colour-palette
-- https://vim.fandom.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen
