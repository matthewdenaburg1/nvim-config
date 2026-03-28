-- my_slate.lua
-- Converted from my_slate.vim using mini.colors
-- Original Maintainer: Ralph Amissah <ralph@amissah.com>
-- Converted by: GitHub Copilot

local MiniColors = require 'mini.colors'

-- Create the colorscheme object with all highlight groups
local colorscheme = MiniColors.as_colorscheme {
  name = 'my_slate',
  groups = {
    -- UI Elements
    Normal = { fg = '#ffffff', bg = '#000000' }, -- White on black
    Cursor = { fg = '#708090', bg = '#f0e68c' }, -- slategrey on khaki
    VertSplit = { fg = '#808080', bg = '#cccccc' }, -- grey40 on grey
    Folded = { fg = '#666666', bg = '#000000' }, -- grey40 on black
    FoldColumn = { fg = '#333333', bg = '#000000' }, -- grey20 on black
    IncSearch = { fg = '#008000', bg = '#000000' }, -- green on black
    ModeMsg = { fg = '#daa520' }, -- goldenrod
    NonText = { fg = '#4169e1', bg = '#000000', bold = true }, -- RoyalBlue on grey15
    Question = { fg = '#00ff7f' }, -- springgreen
    Search = { fg = '#f5deb3', bg = '#cd853f' }, -- wheat on peru
    SpecialKey = { fg = '#9acd32' }, -- yellowgreen
    StatusLine = { fg = '#000000', bg = '#cccccc', bold = true }, -- black on cccccc
    StatusLineNC = { fg = '#808080', bg = '#cccccc' }, -- grey40 on cccccc
    Title = { fg = '#ffd700', bold = true }, -- gold
    Visual = { fg = '#f0e68c', bg = '#4169e1' }, -- khaki on RoyalBlue
    WarningMsg = { fg = '#fa8072' }, -- salmon

    -- Syntax Highlighting
    Comment = { fg = '#999999' }, -- grey40
    Constant = { fg = '#ffa0a0' }, -- ffa0a0
    String = { fg = '#87ceeb' }, -- SkyBlue
    Special = { fg = '#6495ed' }, -- CornflowerBlue
    Identifier = { fg = '#fa8072' }, -- salmon
    Statement = { fg = '#6495ed' }, -- CornflowerBlue
    -- PreProc = { fg = '#ff0000', bg = '#ffffff' }, -- red on white
    Include = { fg = '#ff0000' }, -- red
    Operator = { fg = '#ff0000' }, -- Red
    Define = { fg = '#ffd700', bold = true }, -- gold
    Type = { fg = '#6495ed' }, -- CornflowerBlue
    Function = { fg = '#ffdead' }, -- navajowhite
    Structure = { fg = '#008000' }, -- green

    -- Editor Elements
    LineNr = { fg = '#9f9f9f' }, -- grey50
    Ignore = { fg = '#666666', bold = true }, -- grey40
    Directory = { fg = '#00ced1' }, -- darkcyan
    ErrorMsg = { fg = '#ffffff', bg = '#ff0000', bold = true }, -- White on Red
    VisualNOS = { bold = true, underline = true },
    WildMenu = { fg = '#000000', bg = '#cdcd00' }, -- black on yellow (ctermfg=0 ctermbg=3)

    -- Diff
    DiffAdd = { bg = '#00008b' }, -- darkblue (ctermbg=4)
    DiffChange = { bg = '#8b008b' }, -- darkmagenta (ctermbg=5)
    DiffDelete = { fg = '#00008b', bg = '#008b8b', bold = true }, -- darkblue on darkcyan
    -- DiffText = { bg = '#8b0000', bold = true }, -- darkred

    -- Misc
    Underlined = { underline = true, fg = '#8b008b' }, -- darkmagenta
    Error = { fg = '#ffffff', bg = '#ff0000', bold = true }, -- White on Red
    SpellBad = { fg = '#ffffff', bg = '#ff0000', bold = true }, -- White on Red
    SpellCap = { fg = '#ffffff', bg = '#ff0000', bold = true }, -- White on Red
    SpellRare = { fg = '#ffffff', bg = '#ff0000', bold = true }, -- White on Red
    SpellLocal = { fg = '#ffffff', bg = '#ff0000', bold = true }, -- White on Red
  },

  -- Terminal colors (standard 16 colors)
  terminal = {
    [0] = '#000000', -- Black
    [1] = '#8b0000', -- DarkRed
    [2] = '#008000', -- DarkGreen
    [3] = '#cdcd00', -- DarkYellow
    [4] = '#00008b', -- DarkBlue
    [5] = '#8b008b', -- DarkMagenta
    [6] = '#008b8b', -- DarkCyan
    [7] = '#c0c0c0', -- LightGray
    [8] = '#808080', -- DarkGray
    [9] = '#ff0000', -- Red
    [10] = '#00ff00', -- Green
    [11] = '#ffff00', -- Yellow
    [12] = '#0000ff', -- Blue
    [13] = '#ff00ff', -- Magenta
    [14] = '#00ffff', -- Cyan
    [15] = '#ffffff', -- White
  },
}

-- Set background to dark
vim.o.background = 'dark'

-- Add cterm attributes for terminals without true color support
colorscheme = colorscheme:add_cterm_attributes()

-- Apply the colorscheme
colorscheme:apply()

return colorscheme
