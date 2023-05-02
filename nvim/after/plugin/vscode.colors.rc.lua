local status, vsc = pcall(require, 'vscode')
if not status then
  return
end

vsc.setup({
  transparent = true,
  italic_comments = true,
  disable_nvimtree_bg = true,
  color_overrides = {
    vscLineNumber = '#FFFFFF',
    -- vscPopupHighlightGray = 'NONE',
    vscPopupBack = '#525252',
    vscPopupHighlightBlue = '#525252',
    vscCursorDarkDark = "#3B3B3B"
  },
})

vsc.load()
