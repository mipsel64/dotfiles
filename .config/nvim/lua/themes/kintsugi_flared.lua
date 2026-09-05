-- kintsugi-nvim's "flared" variant (https://github.com/metalelf0/kintsugi-nvim)
-- ported to base46, retuned so Rust reads clearly.
-- Upstream kintsugi collapses several unrelated captures onto one colour:
--   #798283  types + functions + methods + module paths
--   #BCAC8F  variables + params + fields + macros
--   #E08542  operators only, while functions stay grey
-- Palette is 1:1 with upstream; only the capture assignment changes.

local M = {}

-- flared syntax palette
local fg = "#BCAC8F" -- variables, params, fields, operators
local punct = "#7f7b66" -- brackets, delimiters
local comment = "#75715e" -- upstream #5f5f5f is 2.8:1 on this bg; this is 3.7:1
local string = "#cc7f66"
local number = "#DB9833" -- numbers, bools, constants
local keyword = "#D66848" -- control flow, fn, let, use, match
local storage = "#DBAD49" -- mut/pub/const/dyn, self, lifetimes
local type_ = "#798283" -- types, traits, constructors
local func = "#E08542" -- functions, methods
local annot = "#678E87" -- macros, attributes, escapes

M.base_30 = {
  white = "#dddddd",
  darker_black = "#131314",
  black = "#161618", -- nvim bg
  black2 = "#1a1a1d",
  one_bg = "#1c1c1c",
  one_bg2 = "#20201f",
  one_bg3 = "#252523",
  grey = "#3a3a37",
  grey_fg = "#464741",
  grey_fg2 = "#5f5f5f",
  light_grey = comment,
  red = "#b38f8f",
  baby_pink = "#d9a6a6",
  pink = "#d3a3d3",
  line = "#2a2a28",
  green = "#a3be8c",
  vibrant_green = "#c3de9c",
  nord_blue = "#8fa3b3",
  blue = "#6c7a8a",
  yellow = "#ebcb8b",
  sun = "#dbad49",
  purple = "#d3a3d3",
  dark_purple = "#b3a3d3",
  teal = annot,
  orange = func,
  cyan = "#6ac6f2",
  statusline_bg = "#131314",
  lightbg = "#1f1f1e",
  pmenu_bg = "#dbad49",
  folder_bg = "#b8943a",
}

M.base_16 = {
  base00 = "#161618",
  base01 = "#1a1a1d",
  base02 = "#252523",
  base03 = comment,
  base04 = "#969b8c",
  base05 = "#dddddd",
  base06 = "#c9c4b8",
  base07 = fg,
  base08 = keyword,
  base09 = number,
  base0A = type_,
  base0B = string,
  base0C = annot,
  base0D = func,
  base0E = keyword,
  base0F = punct,
}

M.type = "dark"

M.polish_hl = {
  defaults = {
    Comment = { fg = comment, italic = true },
  },

  treesitter = {
    ["@comment"] = { fg = comment, italic = true },
    ["@comment.documentation"] = { fg = comment, italic = true },

    -- neutral: structure, not meaning
    ["@variable"] = { fg = fg },
    ["@variable.parameter"] = { fg = fg },
    ["@variable.member"] = { fg = fg },
    ["@property"] = { fg = fg },
    ["@operator"] = { fg = fg },
    ["@punctuation.bracket"] = { fg = punct },
    ["@punctuation.delimiter"] = { fg = punct },

    -- warm path, cool type at the end
    ["@module"] = { fg = fg },
    ["@module.builtin"] = { fg = fg },

    ["@type"] = { fg = type_ },
    ["@type.builtin"] = { fg = type_ },
    ["@type.definition"] = { fg = type_ },
    ["@constructor"] = { fg = type_ },

    -- values: numbers, bools, consts, Ok/Err/Some/None
    ["@constant"] = { fg = number },
    ["@constant.builtin"] = { fg = number },
    ["@number"] = { fg = number },
    ["@number.float"] = { fg = number },
    ["@boolean"] = { fg = number },

    ["@string"] = { fg = string },
    ["@character"] = { fg = string },
    ["@string.escape"] = { fg = annot },
    ["@string.regexp"] = { fg = annot },
    ["@string.special"] = { fg = annot },
    ["@character.special"] = { fg = annot },

    -- functions get their own orange instead of sharing grey with types
    ["@function"] = { fg = func },
    ["@function.call"] = { fg = func },
    ["@function.method"] = { fg = func },
    ["@function.method.call"] = { fg = func },
    ["@function.builtin"] = { fg = func },

    -- macros and attributes take the one remaining cool accent
    ["@function.macro"] = { fg = annot },
    ["@constant.macro"] = { fg = annot },
    ["@attribute"] = { fg = annot },
    ["@attribute.builtin"] = { fg = annot },
    ["@punctuation.special"] = { fg = annot },

    ["@keyword"] = { fg = keyword, bold = true },
    ["@keyword.function"] = { fg = keyword, bold = true },
    ["@keyword.return"] = { fg = keyword, bold = true },
    ["@keyword.conditional"] = { fg = keyword, bold = true },
    ["@keyword.conditional.ternary"] = { fg = keyword, bold = true },
    ["@keyword.repeat"] = { fg = keyword, bold = true },
    ["@keyword.exception"] = { fg = keyword, bold = true },
    ["@keyword.operator"] = { fg = keyword, bold = true },
    ["@keyword.coroutine"] = { fg = keyword, bold = true },
    ["@keyword.debug"] = { fg = keyword, bold = true },
    ["@keyword.directive"] = { fg = keyword, bold = true },
    ["@keyword.directive.define"] = { fg = keyword, bold = true },
    -- base46 links this to Include; a link outranks a merged fg, so relink
    ["@keyword.import"] = { link = "@keyword" },

    -- storage-ish keywords stay gold: mut, pub, const, static, dyn, impl
    ["@keyword.type"] = { fg = storage, bold = true },
    ["@keyword.modifier"] = { fg = storage, bold = true },
    ["@keyword.storage"] = { fg = storage, bold = true },
    ["@type.qualifier"] = { fg = storage, bold = true },
    ["@variable.builtin"] = { fg = storage, bold = true },
    ["@label"] = { fg = storage, bold = true },

    -- in the Rust grammar @attribute is the lifetime name, not #[...].
    -- the tick is @keyword.modifier, so match it and 'a reads as one token
    ["@attribute.rust"] = { fg = storage },
    ["@lsp.type.lifetime.rust"] = { fg = storage },
    ["@lsp.type.selfKeyword.rust"] = { fg = storage, bold = true },

    ["@tag"] = { fg = storage, bold = true },
    ["@tag.builtin"] = { fg = storage, bold = true },
    ["@tag.attribute"] = { fg = type_ },
    ["@tag.delimiter"] = { fg = punct },
  },
}

-- ANSI palette for :terminal buffers, from kintsugi's terminal.lua. base46
-- derives these from base16 slot order, which is close but not identical.
M.term_colors = {
  "#131314", -- 0  black
  "#b38f8f", -- 1  red
  "#a3be8c", -- 2  green
  "#ebcb8b", -- 3  yellow
  "#6c7a8a", -- 4  blue
  "#b3a3d3", -- 5  magenta
  "#6ac6f2", -- 6  cyan
  "#dddddd", -- 7  white
  "#444444", -- 8  bright black
  "#d9a6a6", -- 9  bright red
  "#c3de9c", -- 10 bright green
  "#fbe4a8", -- 11 bright yellow
  "#8fa3b3", -- 12 bright blue
  "#d3a3d3", -- 13 bright magenta
  "#8ac6f2", -- 14 bright cyan
  "#ffffff", -- 15 bright white
}

M = require("base46").override_theme(M, "kintsugi_flared")

return M
