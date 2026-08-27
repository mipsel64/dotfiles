local M = {}

local sep_l = "  "
local sep_r = "  "

-- flat statusline: white text, transparent bg, arrows only as shape
local stl_hl = {}
for _, g in ipairs {
  "StatusLine", "St_gitIcons", "St_Lsp", "St_LspMsg", "St_EmptySpace", "ST_EmptySpace",
  "St_file", "St_file_sep", "St_cwd_icon", "St_cwd_text", "St_cwd_sep",
  "St_pos_sep", "St_pos_icon", "St_pos_text",
  "St_lspError", "St_lspWarning", "St_LspHints", "St_LspInfo",
} do
  stl_hl[g] = { fg = "white", bg = "NONE", bold = false }
end
for m, col in pairs {
  Normal = "nord_blue",
  Visual = "cyan",
  Insert = "dark_purple",
  Terminal = "green",
  NTerminal = "yellow",
  Replace = "orange",
  Confirm = "teal",
  Command = "green",
  Select = "blue",
} do
  stl_hl["St_" .. m .. "Mode"] = { fg = col, bg = "NONE", bold = true }
  stl_hl["St_" .. m .. "ModeSep"] = { fg = col, bg = "NONE" }
end

M.base46 = {
  theme = "myforest",
  transparency = true,
  hl_override = stl_hl,
  hl_add = { ST_EmptySpace = { fg = "white", bg = "NONE" } },
}

M.ui = {
  cmp = {
    icons_left = false,
    style = "default",
    abbr_maxwidth = 60,
    format_colors = { lsp = true, icon = "󱓻" },
  },

  statusline = {
    enabled = true,
    theme = "default", -- "minimal" hardcodes block separators, arrow is ignored there
    separator_style = { left = sep_l, right = sep_r },
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "noice", "lsp", "cwd", "cursor" },
    modules = {
      -- upstream emits two separators in a row; fine for solid arrows, doubled-up for chevrons
      mode = function()
        local utils = require "nvchad.stl.utils"
        if not utils.is_activewin() then
          return ""
        end
        local m = utils.modes[vim.api.nvim_get_mode().mode]
        return "%#St_" .. m[2] .. "Mode# " .. m[1] .. "%#St_" .. m[2] .. "ModeSep#" .. sep_r
      end,

      noice = function()
        local reg = vim.fn.reg_recording()
        if reg ~= "" then
          return "%#St_lspError# ● recording " .. reg .. " "
        end
        return ""
      end,
    },
  },
  telescope = { style = "bordered" },
}

M.lsp = { signature = false }
return M
