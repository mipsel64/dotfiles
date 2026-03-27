-- ==============================================================================
--   Name:        One Half Dark (Lua)
--   Author:      Son A. Pham <sp@sonpham.me>
--   Url:         https://github.com/sonph/onehalf
--   License:     The MIT License (MIT)
--
--   Converted to Lua and optimized for Treesitter + LSP.
--   Requires termguicolors = true.
-- ==============================================================================

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "onehalfdark"

-- ---------------------------------------------------------------------------
-- Palette (original One Half Dark hex values)
-- ---------------------------------------------------------------------------
local c = {
    black        = "#282c32",
    red          = "#d68383",
    green        = "#98c379",
    yellow       = "#e5c07b",
    blue         = "#61afef",
    purple       = "#c678dd",
    cyan         = "#4a9ea8",
    white        = "#ebe4d5",

    comment      = "#9ca5b4",
    gutter_bg    = "#282c34",
    gutter_fg    = "#919baa",
    non_text     = "#373C45",
    cursor_line  = "#313640",
    color_col    = "#313640",
    selection    = "#474e5d",
    vertsplit    = "#313640",

    dark_red     = "#3e2a2e",
    dark_green   = "#2a3e2e",
    dark_yellow  = "#3e3a2a",
    dark_blue    = "#2a2e3e",

    light_green  = "#b5e890",
    forest_green = "#9dbf9d",
    light_cyan   = "#80dce8",
}

local fg = c.white
local bg = c.black

-- ---------------------------------------------------------------------------
-- Helper
-- ---------------------------------------------------------------------------
local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- ---------------------------------------------------------------------------
-- Terminal colors
-- ---------------------------------------------------------------------------
vim.g.terminal_color_0          = c.black
vim.g.terminal_color_1          = c.red
vim.g.terminal_color_2          = c.green
vim.g.terminal_color_3          = c.yellow
vim.g.terminal_color_4          = c.blue
vim.g.terminal_color_5          = c.purple
vim.g.terminal_color_6          = c.cyan
vim.g.terminal_color_7          = c.white
vim.g.terminal_color_8          = c.black
vim.g.terminal_color_9          = c.red
vim.g.terminal_color_10         = c.green
vim.g.terminal_color_11         = c.yellow
vim.g.terminal_color_12         = c.blue
vim.g.terminal_color_13         = c.purple
vim.g.terminal_color_14         = c.cyan
vim.g.terminal_color_15         = c.white
vim.g.terminal_color_background = bg
vim.g.terminal_color_foreground = fg

-- ---------------------------------------------------------------------------
-- UI highlights
-- ---------------------------------------------------------------------------
hi("Normal", { fg = fg, bg = bg })
hi("NormalFloat", { fg = fg, bg = c.cursor_line })
hi("FloatBorder", { fg = c.comment, bg = c.cursor_line })
hi("Cursor", { fg = bg, bg = c.blue })
hi("CursorColumn", { bg = c.cursor_line })
hi("CursorLine", { bg = c.cursor_line })

hi("LineNr", { fg = c.gutter_fg, bg = c.gutter_bg })
hi("CursorLineNr", { fg = fg, bold = true })

hi("DiffAdd", { fg = c.green })
hi("DiffChange", { fg = c.yellow })
hi("DiffDelete", { fg = c.red })
hi("DiffText", { fg = c.blue })

hi("IncSearch", { fg = bg, bg = c.yellow })
hi("Search", { fg = bg, bg = c.yellow })
hi("CurSearch", { fg = bg, bg = c.yellow, bold = true })
hi("Substitute", { fg = bg, bg = c.red })

hi("ErrorMsg", { fg = c.red, bold = true })
hi("ModeMsg", { fg = fg, bold = true })
hi("MoreMsg", { fg = fg })
hi("WarningMsg", { fg = c.red })
hi("Question", { fg = c.purple })

hi("Pmenu", { fg = fg, bg = c.cursor_line })
hi("PmenuSel", { fg = fg, bg = c.blue })
hi("PmenuSbar", { bg = c.selection })
hi("PmenuThumb", { bg = c.gutter_fg })

hi("SpellBad", { sp = c.red, undercurl = true })
hi("SpellCap", { sp = c.yellow, undercurl = true })
hi("SpellLocal", { sp = c.yellow, undercurl = true })
hi("SpellRare", { sp = c.yellow, undercurl = true })

hi("StatusLine", { fg = c.blue, bg = c.cursor_line })
hi("StatusLineNC", { fg = c.comment, bg = c.cursor_line })
hi("TabLine", { fg = c.comment, bg = c.cursor_line })
hi("TabLineFill", { fg = c.comment, bg = c.cursor_line })
hi("TabLineSel", { fg = fg, bg = bg })

hi("Visual", { bg = c.selection })
hi("VisualNOS", { bg = c.selection })

hi("ColorColumn", { bg = c.color_col })
hi("Conceal", { fg = fg })
hi("Directory", { fg = c.blue })
hi("VertSplit", { fg = c.vertsplit, bg = c.vertsplit })
hi("WinSeparator", { fg = c.comment })
hi("Folded", { fg = c.comment, bg = c.cursor_line })
hi("FoldColumn", { fg = c.gutter_fg, bg = c.gutter_bg })
hi("SignColumn", { fg = fg, bg = c.gutter_bg })

hi("MatchParen", { fg = c.blue, underline = true })
hi("SpecialKey", { fg = c.non_text })
hi("Title", { fg = c.green, bold = true })
hi("WildMenu", { fg = fg, bg = c.selection })

hi("WinBar", { fg = fg, bold = true })
hi("WinBarNC", { fg = c.comment })

-- ---------------------------------------------------------------------------
-- Syntax (legacy vim groups)
-- ---------------------------------------------------------------------------
hi("Whitespace", { fg = c.non_text })
hi("NonText", { fg = c.non_text })
hi("Comment", { fg = c.comment, italic = true })
hi("Constant", { fg = c.cyan })
hi("String", { fg = c.forest_green })
hi("Character", { fg = c.forest_green })
hi("Number", { fg = c.yellow })
hi("Boolean", { fg = c.yellow })
hi("Float", { fg = c.yellow })

hi("Identifier", { fg = c.red })
hi("Function", { fg = c.light_green })
hi("Statement", { fg = c.red })

hi("Conditional", { fg = c.red })
hi("Repeat", { fg = c.red })
hi("Label", { fg = c.red })
hi("Operator", { fg = fg })
hi("Keyword", { fg = c.red })
hi("Exception", { fg = c.red })

hi("PreProc", { fg = c.yellow })
hi("Include", { fg = c.red })
hi("Define", { fg = c.red })
hi("Macro", { fg = c.red })
hi("PreCondit", { fg = c.yellow })

hi("Type", { fg = c.yellow })
hi("StorageClass", { fg = c.yellow })
hi("Structure", { fg = c.yellow })
hi("Typedef", { fg = c.yellow })

hi("Special", { fg = c.blue })
hi("SpecialChar", { fg = c.cyan })
hi("Tag", { fg = c.red })
hi("Delimiter", { fg = fg })
hi("SpecialComment", { fg = c.comment, bold = true })
hi("Debug", { fg = c.red })
hi("Underlined", { underline = true })
hi("Ignore", { fg = c.comment })
hi("Error", { fg = c.red, bg = c.dark_red, bold = true })
hi("Todo", { fg = c.purple, bold = true })

-- ---------------------------------------------------------------------------
-- Treesitter highlight groups (@capture based, Neovim 0.9+)
-- ---------------------------------------------------------------------------

-- Identifiers
hi("@variable", { fg = fg })
hi("@variable.builtin", { fg = c.red, italic = true })
hi("@variable.parameter", { fg = c.white })
hi("@variable.member", { fg = c.light_cyan })

hi("@constant", { fg = c.cyan })
hi("@constant.builtin", { fg = c.cyan, bold = true })
hi("@constant.macro", { fg = c.cyan })

hi("@module", { fg = c.yellow })
hi("@module.builtin", { fg = c.yellow, italic = true })

hi("@label", { fg = c.purple })

-- Literals
hi("@string", { fg = c.forest_green })
hi("@string.documentation", { fg = c.forest_green, italic = true })
hi("@string.regexp", { fg = c.cyan })
hi("@string.escape", { fg = c.light_green, bold = true })
hi("@string.special", { fg = c.cyan })
hi("@string.special.symbol", { fg = c.cyan })
hi("@string.special.url", { fg = c.blue, underline = true })
hi("@string.special.path", { fg = c.blue })

hi("@character", { fg = c.forest_green })
hi("@character.special", { fg = c.cyan })
hi("@number", { fg = c.yellow })
hi("@number.float", { fg = c.yellow })
hi("@boolean", { fg = c.yellow })

-- Types
hi("@type", { fg = c.yellow })
hi("@type.builtin", { fg = c.yellow, italic = true })
hi("@type.definition", { fg = c.yellow })
hi("@type.qualifier", { fg = c.purple })

hi("@attribute", { fg = c.yellow })
hi("@attribute.builtin", { fg = c.yellow, italic = true })
hi("@property", { fg = c.light_cyan })

-- Functions
hi("@function", { fg = c.light_green })
hi("@function.builtin", { fg = c.light_green, italic = true })
hi("@function.call", { fg = c.light_green })
hi("@function.macro", { fg = c.red })
hi("@function.method", { fg = c.light_green })
hi("@function.method.call", { fg = c.light_green })

hi("@constructor", { fg = c.yellow })
hi("@operator", { fg = fg })

-- Keywords
hi("@keyword", { fg = c.red })
hi("@keyword.coroutine", { fg = c.red, italic = true })
hi("@keyword.function", { fg = c.red })
hi("@keyword.operator", { fg = c.red })
hi("@keyword.import", { fg = c.red })
hi("@keyword.type", { fg = c.red })
hi("@keyword.modifier", { fg = c.red })
hi("@keyword.repeat", { fg = c.red })
hi("@keyword.return", { fg = c.red })
hi("@keyword.debug", { fg = c.red })
hi("@keyword.exception", { fg = c.red })
hi("@keyword.conditional", { fg = c.red })
hi("@keyword.conditional.ternary", { fg = c.red })
hi("@keyword.directive", { fg = c.yellow })
hi("@keyword.directive.define", { fg = c.red })

-- Punctuation
hi("@punctuation.delimiter", { fg = fg })
hi("@punctuation.bracket", { fg = fg })
hi("@punctuation.special", { fg = c.cyan })

-- Comments
hi("@comment", { fg = c.comment, italic = true })
hi("@comment.documentation", { fg = c.comment, italic = true })
hi("@comment.error", { fg = c.red, bold = true })
hi("@comment.warning", { fg = c.yellow, bold = true })
hi("@comment.todo", { fg = c.purple, bold = true })
hi("@comment.note", { fg = c.blue, bold = true })

-- Markup (markdown, etc.)
hi("@markup.strong", { bold = true })
hi("@markup.italic", { italic = true })
hi("@markup.strikethrough", { strikethrough = true })
hi("@markup.underline", { underline = true })
hi("@markup.heading", { fg = c.blue, bold = true })
hi("@markup.heading.1", { fg = c.red, bold = true })
hi("@markup.heading.2", { fg = c.yellow, bold = true })
hi("@markup.heading.3", { fg = c.green, bold = true })
hi("@markup.heading.4", { fg = c.cyan, bold = true })
hi("@markup.heading.5", { fg = c.blue, bold = true })
hi("@markup.heading.6", { fg = c.purple, bold = true })
hi("@markup.quote", { fg = c.comment, italic = true })
hi("@markup.math", { fg = c.cyan })
hi("@markup.environment", { fg = c.yellow })
hi("@markup.link", { fg = c.blue, underline = true })
hi("@markup.link.label", { fg = c.blue })
hi("@markup.link.url", { fg = c.cyan, underline = true })
hi("@markup.raw", { fg = c.green })
hi("@markup.raw.block", { fg = c.green })
hi("@markup.list", { fg = c.red })
hi("@markup.list.checked", { fg = c.green })
hi("@markup.list.unchecked", { fg = c.comment })

-- Tags (HTML/JSX)
hi("@tag", { fg = c.red })
hi("@tag.builtin", { fg = c.red })
hi("@tag.attribute", { fg = c.yellow })
hi("@tag.delimiter", { fg = c.comment })

-- Diff
hi("@diff.plus", { fg = c.green })
hi("@diff.minus", { fg = c.red })
hi("@diff.delta", { fg = c.yellow })

-- ---------------------------------------------------------------------------
-- LSP Semantic Tokens (Neovim 0.9+)
-- ---------------------------------------------------------------------------
hi("@lsp.type.class", { fg = c.yellow })
hi("@lsp.type.decorator", { fg = c.yellow })
hi("@lsp.type.enum", { fg = c.yellow })
hi("@lsp.type.enumMember", { fg = c.cyan })
hi("@lsp.type.function", { fg = c.light_green })
hi("@lsp.type.interface", { fg = c.yellow, italic = true })
hi("@lsp.type.macro", { fg = c.purple })
hi("@lsp.type.method", { fg = c.light_green })
hi("@lsp.type.namespace", { fg = c.yellow })
hi("@lsp.type.parameter", { fg = c.white })
hi("@lsp.type.property", { fg = c.light_cyan })
hi("@lsp.type.struct", { fg = c.yellow })
hi("@lsp.type.type", { fg = c.yellow })
hi("@lsp.type.typeParameter", { fg = c.yellow, italic = true })
hi("@lsp.type.variable", { fg = fg })

hi("@lsp.mod.deprecated", { strikethrough = true })
hi("@lsp.mod.readonly", { italic = true })
hi("@lsp.mod.defaultLibrary", { italic = true })

-- ---------------------------------------------------------------------------
-- Diagnostics
-- ---------------------------------------------------------------------------
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.cyan })
hi("DiagnosticOk", { fg = c.green })

hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.yellow, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = c.blue, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = c.cyan, undercurl = true })
hi("DiagnosticUnderlineOk", { sp = c.green, undercurl = true })

hi("DiagnosticVirtualTextError", { fg = c.red, bg = c.dark_red })
hi("DiagnosticVirtualTextWarn", { fg = c.yellow, bg = c.dark_yellow })
hi("DiagnosticVirtualTextInfo", { fg = c.blue, bg = c.dark_blue })
hi("DiagnosticVirtualTextHint", { fg = c.cyan })
hi("DiagnosticVirtualTextOk", { fg = c.green, bg = c.dark_green })

hi("DiagnosticFloatingError", { fg = c.red })
hi("DiagnosticFloatingWarn", { fg = c.yellow })
hi("DiagnosticFloatingInfo", { fg = c.blue })
hi("DiagnosticFloatingHint", { fg = c.cyan })
hi("DiagnosticFloatingOk", { fg = c.green })

hi("DiagnosticSignError", { fg = c.red, bg = c.gutter_bg })
hi("DiagnosticSignWarn", { fg = c.yellow, bg = c.gutter_bg })
hi("DiagnosticSignInfo", { fg = c.blue, bg = c.gutter_bg })
hi("DiagnosticSignHint", { fg = c.cyan, bg = c.gutter_bg })
hi("DiagnosticSignOk", { fg = c.green, bg = c.gutter_bg })

-- ---------------------------------------------------------------------------
-- Plugin: gitsigns.nvim
-- ---------------------------------------------------------------------------
hi("GitSignsAdd", { fg = c.green, bg = c.gutter_bg })
hi("GitSignsChange", { fg = c.yellow, bg = c.gutter_bg })
hi("GitSignsDelete", { fg = c.red, bg = c.gutter_bg })
hi("GitSignsAddNr", { fg = c.green })
hi("GitSignsChangeNr", { fg = c.yellow })
hi("GitSignsDeleteNr", { fg = c.red })
hi("GitSignsAddLn", { bg = c.dark_green })
hi("GitSignsChangeLn", { bg = c.dark_yellow })
hi("GitSignsDeleteLn", { bg = c.dark_red })

-- ---------------------------------------------------------------------------
-- Plugin: telescope.nvim
-- ---------------------------------------------------------------------------
hi("TelescopeNormal", { fg = fg, bg = bg })
hi("TelescopeBorder", { fg = c.comment, bg = bg })
hi("TelescopePromptNormal", { fg = fg, bg = c.cursor_line })
hi("TelescopePromptBorder", { fg = c.comment, bg = c.cursor_line })
hi("TelescopePromptTitle", { fg = bg, bg = c.blue, bold = true })
hi("TelescopePreviewTitle", { fg = bg, bg = c.green, bold = true })
hi("TelescopeResultsTitle", { fg = bg, bg = c.purple, bold = true })
hi("TelescopeSelection", { bg = c.cursor_line })
hi("TelescopeSelectionCaret", { fg = c.blue })
hi("TelescopeMatching", { fg = c.yellow, bold = true })

-- ---------------------------------------------------------------------------
-- Plugin: neo-tree.nvim
-- ---------------------------------------------------------------------------
hi("NeoTreeNormal", { fg = fg, bg = bg })
hi("NeoTreeNormalNC", { fg = fg, bg = bg })
hi("NeoTreeDirectoryName", { fg = c.blue })
hi("NeoTreeDirectoryIcon", { fg = c.blue })
hi("NeoTreeRootName", { fg = c.purple, bold = true })
hi("NeoTreeFileName", { fg = fg })
hi("NeoTreeFileIcon", { fg = c.blue })
hi("NeoTreeFileNameOpened", { fg = c.green })
hi("NeoTreeIndentMarker", { fg = c.non_text })
hi("NeoTreeGitAdded", { fg = c.green })
hi("NeoTreeGitConflict", { fg = c.red })
hi("NeoTreeGitDeleted", { fg = c.red })
hi("NeoTreeGitModified", { fg = c.yellow })
hi("NeoTreeGitUntracked", { fg = c.cyan })
hi("NeoTreeDotfile", { fg = c.comment })
hi("NeoTreeTitleBar", { fg = bg, bg = c.blue, bold = true })

-- ---------------------------------------------------------------------------
-- Plugin: bufferline.nvim
-- ---------------------------------------------------------------------------
hi("BufferLineFill", { bg = c.black })

-- ---------------------------------------------------------------------------
-- Plugin: nvim-cmp
-- ---------------------------------------------------------------------------
hi("CmpItemAbbrMatch", { fg = c.blue, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = c.blue, bold = true })
hi("CmpItemAbbrDeprecated", { fg = c.comment, strikethrough = true })
hi("CmpItemKindFunction", { fg = c.blue })
hi("CmpItemKindMethod", { fg = c.blue })
hi("CmpItemKindVariable", { fg = c.red })
hi("CmpItemKindField", { fg = c.red })
hi("CmpItemKindClass", { fg = c.yellow })
hi("CmpItemKindInterface", { fg = c.yellow })
hi("CmpItemKindModule", { fg = c.yellow })
hi("CmpItemKindProperty", { fg = c.red })
hi("CmpItemKindKeyword", { fg = c.purple })
hi("CmpItemKindText", { fg = c.green })
hi("CmpItemKindSnippet", { fg = c.purple })
hi("CmpItemKindConstant", { fg = c.cyan })
hi("CmpItemKindEnum", { fg = c.yellow })
hi("CmpItemKindEnumMember", { fg = c.cyan })
hi("CmpItemKindStruct", { fg = c.yellow })
hi("CmpItemKindOperator", { fg = fg })
hi("CmpItemKindTypeParameter", { fg = c.yellow })

-- ---------------------------------------------------------------------------
-- Plugin: fidget.nvim
-- ---------------------------------------------------------------------------
hi("FidgetTitle", { fg = c.blue, bold = true })
hi("FidgetTask", { fg = c.comment })

-- ---------------------------------------------------------------------------
-- Plugin: nvim-treesitter-context
-- ---------------------------------------------------------------------------
hi("TreesitterContext", { fg = c.gutter_fg, bg = c.gutter_bg })
hi("TreesitterContextBottom", { underline = true })
hi("TreesitterContextLineNumber", { fg = fg, bg = c.gutter_bg })
hi("TreesitterContextLineNumberBottom", { underline = true })

-- ---------------------------------------------------------------------------
-- Fugitive / diff
-- ---------------------------------------------------------------------------
hi("diffAdded", { fg = c.green })
hi("diffRemoved", { fg = c.red })
hi("diffChanged", { fg = c.yellow })

-- ---------------------------------------------------------------------------
-- Git commit
-- ---------------------------------------------------------------------------
hi("gitcommitComment", { fg = c.comment })
hi("gitcommitUnmerged", { fg = c.red })
hi("gitcommitOnBranch", { fg = fg })
hi("gitcommitBranch", { fg = c.purple })
hi("gitcommitDiscardedType", { fg = c.red })
hi("gitcommitSelectedType", { fg = c.green })
hi("gitcommitHeader", { fg = fg })
hi("gitcommitUntrackedFile", { fg = c.cyan })
hi("gitcommitDiscardedFile", { fg = c.red })
hi("gitcommitSelectedFile", { fg = c.green })
hi("gitcommitUnmergedFile", { fg = c.yellow })
hi("gitcommitFile", { fg = fg })

hi("gitcommitNoBranch", { link = "gitcommitBranch" })
hi("gitcommitUntracked", { link = "gitcommitComment" })
hi("gitcommitDiscarded", { link = "gitcommitComment" })
hi("gitcommitSelected", { link = "gitcommitComment" })
hi("gitcommitDiscardedArrow", { link = "gitcommitDiscardedFile" })
hi("gitcommitSelectedArrow", { link = "gitcommitSelectedFile" })
hi("gitcommitUnmergedArrow", { link = "gitcommitUnmergedFile" })
