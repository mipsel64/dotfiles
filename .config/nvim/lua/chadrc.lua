local M = {}

local sep_l = "  "
local sep_r = "  "

-- statusline: every colored block becomes colored text on a transparent bar
local stl_hl = { StatusLine = { bg = "NONE" }, StatusLineNC = { bg = "NONE" } }
for _, g in ipairs {
  "St_gitIcons", "St_Lsp", "St_LspMsg", "St_file", "St_cwd_sep",
  "St_pos_sep", "St_pos_text", "St_lspError", "St_lspWarning", "St_LspHints", "St_LspInfo",
} do
  stl_hl[g] = { bg = "NONE" }
end

-- these carried their color in the bg, so it has to move to the fg
stl_hl.St_cwd_icon = { fg = "red", bg = "NONE" }
stl_hl.St_cwd_text = { fg = "red", bg = "NONE" }
stl_hl.St_pos_icon = { fg = "green", bg = "NONE" }
stl_hl.St_file_sep = { fg = "white", bg = "NONE" }

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
    theme = "default",
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
