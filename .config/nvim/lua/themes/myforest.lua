-- base46's everforest, retuned so Rust reads clearly.
-- Stock everforest collapses several unrelated captures onto one colour:
--   #d699b6  numbers + constants + every bracket/comma/semicolon
--   #7fbbb3  struct fields + params + module paths + macros
--   #83c092  types + `for`/`while`
--   #a7c080  functions + `use`
-- Palette and UI are untouched; only the capture assignment changes.

local base = require "base46.themes.everforest"

-- upstream everforest (sainnhe) palette
local fg = "#d3c6aa"
local red = "#e67e80"
local orange = "#e69875"
local yellow = "#dbbc7f"
local green = "#a7c080"
local aqua = "#83c092"
local blue = "#7fbbb3"
local purple = "#d699b6"
local grey1 = "#859289"
local grey2 = "#9da9a0"

local M = {}

M.base_30 = base.base_30
M.base_16 = base.base_16
M.type = base.type

M.polish_hl = {
  defaults = {
    -- stock sits at #545c62, only 1.9:1 on this bg; grey1 gives 4.0:1
    Comment = { fg = grey1, italic = true },
  },

  treesitter = {
    ["@tag"] = { fg = orange },
    ["@tag.delimiter"] = { fg = aqua },

    ["@comment"] = { fg = grey1, italic = true },
    ["@comment.documentation"] = { fg = grey2, italic = true },

    -- neutral: structure, not meaning
    ["@variable"] = { fg = fg },
    ["@variable.parameter"] = { fg = fg },
    ["@operator"] = { fg = fg },
    ["@punctuation.bracket"] = { fg = fg },
    ["@punctuation.delimiter"] = { fg = fg },

    -- fields keep blue to themselves
    ["@variable.member"] = { fg = blue },
    ["@variable.member.key"] = { fg = blue },
    ["@property"] = { fg = blue },

    -- paths recede so the type at the end stands out
    ["@module"] = { fg = grey2 },

    ["@type"] = { fg = aqua },
    ["@type.builtin"] = { fg = aqua },
    ["@type.definition"] = { fg = aqua },
    ["@constructor"] = { fg = aqua },

    -- values: numbers, bools, consts, enum variants, Ok/Err/Some/None, self
    ["@constant"] = { fg = purple },
    ["@constant.builtin"] = { fg = purple },
    ["@variable.builtin"] = { fg = purple },
    ["@number"] = { fg = purple },
    ["@number.float"] = { fg = purple },
    ["@boolean"] = { fg = purple },

    ["@string"] = { fg = yellow },
    ["@character"] = { fg = yellow },
    ["@string.escape"] = { fg = orange },
    ["@string.regexp"] = { fg = orange },

    ["@function"] = { fg = green },
    ["@function.call"] = { fg = green },
    ["@function.method"] = { fg = green },
    ["@function.method.call"] = { fg = green },
    ["@function.builtin"] = { fg = green },

    -- macros get orange so println! stops looking like a field
    ["@function.macro"] = { fg = orange },
    ["@punctuation.special"] = { fg = orange },
    ["@attribute"] = { fg = orange },

    -- every keyword flavour stays red, including the two that escaped
    ["@keyword"] = { fg = red },
    ["@keyword.function"] = { fg = red },
    ["@keyword.type"] = { fg = red },
    ["@keyword.return"] = { fg = red },
    ["@keyword.conditional"] = { fg = red },
    ["@keyword.conditional.ternary"] = { fg = red },
    ["@keyword.exception"] = { fg = red },
    ["@keyword.operator"] = { fg = red },
    ["@keyword.modifier"] = { fg = red },
    ["@keyword.coroutine"] = { fg = red },
    ["@keyword.storage"] = { fg = red },
    ["@keyword.directive"] = { fg = red },
    ["@keyword.directive.define"] = { fg = red },
    ["@keyword.debug"] = { fg = red },
    ["@keyword.repeat"] = { fg = red }, -- was aqua, i.e. the same as String
    -- base46 links this to Include; a link outranks a merged fg, so relink
    ["@keyword.import"] = { link = "@keyword" }, -- was green, i.e. a function

    -- in the Rust grammar @attribute is the lifetime name, not #[...].
    -- the tick is @keyword.modifier, so match it and 'a reads as one token
    ["@attribute.rust"] = { fg = red },
    ["@label"] = { fg = red },
  },
}

-- ANSI palette for :terminal buffers. base46 derives these from base16 slot
-- order (base08=red, base0D=blue, ...), a convention everforest's base_16 does
-- not follow, so the stock mapping renders red as blue and green as yellow.
M.term_colors = {
  "#343f44", -- 0  black
  "#e67e80", -- 1  red
  "#a7c080", -- 2  green
  "#dbbc7f", -- 3  yellow
  "#7fbbb3", -- 4  blue
  "#d699b6", -- 5  magenta
  "#83c092", -- 6  cyan
  "#d3c6aa", -- 7  white
  "#859289", -- 8  bright black
  "#e67e80", -- 9  bright red
  "#a7c080", -- 10 bright green
  "#dbbc7f", -- 11 bright yellow
  "#7fbbb3", -- 12 bright blue
  "#d699b6", -- 13 bright magenta
  "#83c092", -- 14 bright cyan
  "#e7dabe", -- 15 bright white
}

M = require("base46").override_theme(M, "myforest")

return M
