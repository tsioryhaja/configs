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


local colors = {
  white = "#dee1e6",
  darker_black = "#1a1a1a",
  black = "#1E1E1E", --  nvim bg
  black2 = "#252525",
  one_bg = "#282828",
  one_bg2 = "#313131",
  one_bg3 = "#3a3a3a",
  grey = "#444444",
  grey_fg = "#4e4e4e",
  grey_fg2 = "#585858",
  light_grey = "#626262",
  red = "#D16969",
  baby_pink = "#ea696f",
  pink = "#bb7cb6",
  line = "#2e2e2e", -- for lines like vertsplit
  green = "#B5CEA8",
  green1 = "#4EC994",
  vibrant_green = "#bfd8b2",
  blue = "#569CD6",
  nord_blue = "#60a6e0",
  yellow = "#D7BA7D",
  sun = "#e1c487",
  purple = "#c68aee",
  dark_purple = "#b77bdf",
  teal = "#4294D6",
  orange = "#d3967d",
  cyan = "#9CDCFE",
  statusline_bg = "#242424",
  lightbg = "#303030",
  pmenu_bg = "#60a6e0",
  folder_bg = "#7A8A92",
}

local highlights = {

  TelescopeBorder = {
    fg = colors.darker_black,
    bg = colors.darker_black,
  },

  TelescopePromptBorder = {
    fg = colors.black2,
    bg = colors.black2,
  },

  TelescopePromptNormal = {
    fg = colors.white,
    bg = colors.black2,
  },

  TelescopePromptPrefix = {
    fg = colors.red,
    bg = colors.black2,
  },

  TelescopeNormal = { bg = colors.darker_black },

  TelescopePreviewTitle = {
    fg = colors.black,
    bg = colors.green,
  },

  TelescopePromptTitle = {
    fg = colors.black,
    bg = colors.red,
  },

  TelescopeResultsTitle = {
    fg = colors.darker_black,
    bg = colors.darker_black,
  },

  TelescopeSelection = { bg = colors.black2, fg = colors.white },

  TelescopeResultsDiffAdd = {
    fg = colors.green,
  },

  TelescopeResultsDiffChange = {
    fg = colors.yellow,
  },

  TelescopeResultsDiffDelete = {
    fg = colors.red,
  },
}

for k, v in pairs(highlights) do
  vim.api.nvim_set_hl(0, k, v)
end


local highlights_1 = {
  -- Sets the highlight for selected items within the picker.
  TelescopeSelection = { default = true, link = "Visual" },
  TelescopeSelectionCaret = { default = true, link = "TelescopeSelection" },
  TelescopeMultiSelection = { default = true, link = "Type" },
  TelescopeMultiIcon = { default = true, link = "Identifier" },

  -- "Normal" in the floating windows created by telescope.
  TelescopeNormal = { default = true, link = "Normal" },
  TelescopePreviewNormal = { default = true, link = "TelescopeNormal" },
  TelescopePromptNormal = { default = true, link = "TelescopeNormal" },
  TelescopeResultsNormal = { default = true, link = "TelescopeNormal" },

  -- Border highlight groups.
  --   Use TelescopeBorder to override the default.
  --   Otherwise set them specifically
  TelescopeBorder = { default = true, link = "TelescopeNormal" },
  TelescopePromptBorder = { default = false, link = "TelescopeBorder" },
  TelescopeResultsBorder = { default = false, link = "TelescopeBorder" },
  TelescopePreviewBorder = { default = false, link = "TelescopeBorder" },

  -- Title highlight groups.
  --   Use TelescopeTitle to override the default.
  --   Otherwise set them specifically
  TelescopeTitle = { default = true, link = "TelescopeBorder" },
  TelescopePromptTitle = { default = true, link = "TelescopeTitle" },
  TelescopeResultsTitle = { default = true, link = "TelescopeTitle" },
  TelescopePreviewTitle = { default = true, link = "TelescopeTitle" },

  TelescopePromptCounter = { default = true, link = "NonText" },

  -- Used for highlighting characters that you match.
  TelescopeMatching = { default = true, link = "Special" },

  -- Used for the prompt prefix
  TelescopePromptPrefix = { default = true, link = "Identifier" },

  -- Used for highlighting the matched line inside Previewer. Works only for (vim_buffer_ previewer)
  TelescopePreviewLine = { default = true, link = "Visual" },
  TelescopePreviewMatch = { default = true, link = "Search" },

  TelescopePreviewPipe = { default = true, link = "Constant" },
  TelescopePreviewCharDev = { default = true, link = "Constant" },
  TelescopePreviewDirectory = { default = true, link = "Directory" },
  TelescopePreviewBlock = { default = true, link = "Constant" },
  TelescopePreviewLink = { default = true, link = "Special" },
  TelescopePreviewSocket = { default = true, link = "Statement" },
  TelescopePreviewRead = { default = true, link = "Constant" },
  TelescopePreviewWrite = { default = true, link = "Statement" },
  TelescopePreviewExecute = { default = true, link = "String" },
  TelescopePreviewHyphen = { default = true, link = "NonText" },
  TelescopePreviewSticky = { default = true, link = "Keyword" },
  TelescopePreviewSize = { default = true, link = "String" },
  TelescopePreviewUser = { default = true, link = "Constant" },
  TelescopePreviewGroup = { default = true, link = "Constant" },
  TelescopePreviewDate = { default = true, link = "Directory" },
  TelescopePreviewMessage = { default = true, link = "TelescopePreviewNormal" },
  TelescopePreviewMessageFillchar = { default = true, link = "TelescopePreviewMessage" },

  -- Used for Picker specific Results highlighting
  TelescopeResultsClass = { default = true, link = "Function" },
  TelescopeResultsConstant = { default = true, link = "Constant" },
  TelescopeResultsField = { default = true, link = "Function" },
  TelescopeResultsFunction = { default = true, link = "Function" },
  TelescopeResultsMethod = { default = true, link = "Method" },
  TelescopeResultsOperator = { default = true, link = "Operator" },
  TelescopeResultsStruct = { default = true, link = "Struct" },
  TelescopeResultsVariable = { default = true, link = "SpecialChar" },

  TelescopeResultsLineNr = { default = true, link = "LineNr" },
  TelescopeResultsIdentifier = { default = true, link = "Identifier" },
  TelescopeResultsNumber = { default = true, link = "Number" },
  TelescopeResultsComment = { default = true, link = "Comment" },
  TelescopeResultsSpecialComment = { default = true, link = "SpecialComment" },

  -- Used for git status Results highlighting
  TelescopeResultsDiffChange = { default = true, link = "DiffChange" },
  TelescopeResultsDiffAdd = { default = true, link = "DiffAdd" },
  TelescopeResultsDiffDelete = { default = true, link = "DiffDelete" },
  TelescopeResultsDiffUntracked = { default = true, link = "NonText" },
}

for k, v in pairs(highlights_1) do
  vim.api.nvim_set_hl(0, k, v)
end

