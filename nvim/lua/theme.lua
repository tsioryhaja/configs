local status, kanagawa = pcall(require, "kanagawa")
if (not status) then
  return
end

kanagawa.setup{
  -- theme = "wave",
  -- theme = "dragon",
  -- theme = "lotus",
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none"
        }
      }
    }
  }
}

vim.cmd":colorscheme kanagawa-wave"
-- vim.cmd":colorscheme kanagawa-dragon"
-- vim.cmd":colorscheme kanagawa-lotus"
