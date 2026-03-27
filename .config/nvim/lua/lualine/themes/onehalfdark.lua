-- Lualine theme: One Half Dark
-- Converted from vim-airline onehalfdark theme

local colors = {
    light   = '#dcdfe4',
    med_hi  = '#5d677a',
    med_lo  = '#313640',
    dark    = '#282c34',
    green   = '#98c379',
    blue    = '#61afef',
    yellow  = '#e5c07b',
    red     = '#e06c75',
}

return {
    normal = {
        a = { fg = colors.dark, bg = colors.green, gui = 'bold' },
        b = { fg = colors.light, bg = colors.med_hi },
        c = { fg = colors.green, bg = colors.med_lo },
    },
    insert = {
        a = { fg = colors.med_lo, bg = colors.blue, gui = 'bold' },
        b = { fg = colors.light, bg = colors.med_hi },
        c = { fg = colors.blue, bg = colors.med_lo },
    },
    visual = {
        a = { fg = colors.dark, bg = colors.yellow, gui = 'bold' },
        b = { fg = colors.light, bg = colors.med_hi },
        c = { fg = colors.yellow, bg = colors.med_lo },
    },
    replace = {
        a = { fg = colors.med_lo, bg = colors.red, gui = 'bold' },
        b = { fg = colors.light, bg = colors.med_hi },
        c = { fg = colors.red, bg = colors.med_lo },
    },
    command = {
        a = { fg = colors.dark, bg = colors.green, gui = 'bold' },
        b = { fg = colors.light, bg = colors.med_hi },
        c = { fg = colors.green, bg = colors.med_lo },
    },
    inactive = {
        a = { fg = colors.light, bg = colors.med_lo },
        b = { fg = colors.light, bg = colors.med_lo },
        c = { fg = colors.light, bg = colors.med_lo },
    },
}
