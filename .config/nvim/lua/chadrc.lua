local M = {}

M.base46 = {
    theme = "gruvchad",
    hl_override = {
        TelescopeMatching = { fg = "cyan" },
        TelescopeSelection = { fg = "cyan" },
        TelescopeSelectionCaret = { fg = "cyan" },
    },
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
        theme = "default",         -- default/vscode/vscode_colored/minimal
        separator_style = "arrow", -- default/round/block/arrow
        order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "noice", "lsp", "cwd", "cursor" },
        modules = {
            noice = function()
                local reg = vim.fn.reg_recording()
                if reg ~= "" then
                    return "%#St_lspError# ● recording " .. reg .. " "
                end
                return ""
            end,
        },
    },
    telescope = { style = "bordered" }
}

return M
