local status, kanagawa = pcall(require, "kanagawa")
if (not status) then
  return
end

kanagawa.setup{
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
