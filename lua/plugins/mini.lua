vim.pack.add({
    { src = "https://github.com/echasnovski/mini.nvim.git", version = "main" },
})

local icons = require('mini.icons')
local surround = require('mini.surround')
local pairs = require('mini.pairs')
local comment = require('mini.comment')
local move = require('mini.move')
local hipatterns = require('mini.hipatterns')
local jump = require('mini.jump')
local jump2d = require('mini.jump2d')
local tabline = require('mini.tabline')

icons.setup({
    extension = {
        c = { glyph = '', hl = 'CIconHL' },
    },
})
icons.mock_nvim_web_devicons()

vim.api.nvim_set_hl(0, 'CIconHL', { fg = '#599EFF' })

surround.setup({
    mappings = {
        add = 'gsa',            -- Agregar en Normal y Visual
        delete = 'gsd',         -- Borrar
        find = 'gsf',           -- Buscar a la derecha
        find_left = 'gsF',      -- Buscar a la izquierda
        highlight = 'gsh',      -- Resaltar
        replace = 'gsr',        -- Reemplazar
        update_n_lines = 'gsn', -- Actualizar cantidad de líneas

        suffix_last = 'l',      -- Sufijo para "prev"
        suffix_next = 'n',      -- Sufijo para "next"
    },
})

pairs.setup()
comment.setup()
move.setup()

hipatterns.setup({
    highlighters = {
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

jump.setup()
jump2d.setup()

tabline.setup({
    show_icons = true,
    format = function(buf_id, label)
        local suffix = vim.bo[buf_id].modified and '+ ' or ''
        return " " .. tabline.default_format(buf_id, label) .. suffix .. " "
    end,
    tabpage_section = 'right',
})

vim.api.nvim_set_hl(0, "MiniTablineFill", { bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniTablineCurrent", {
    bg = "#3a4261",
    fg = "#c0caf5",
    underline = true,
    sp = "#7aa2f7",
    bold = true,
})
vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", {
    bg = "#3a4261",
    fg = "#ff9e3b",
    underline = true,
    sp = "#ff9e3b",
    bold = true,
})
