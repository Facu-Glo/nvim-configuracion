vim.pack.add({
    { src = "https://github.com/echasnovski/mini.nvim.git",         version = "main" },
})

require('mini.icons').setup({
    extension = {
        c = { glyph = '', hl = 'CIconHL' },
    },
})
vim.api.nvim_set_hl(0, 'CIconHL', { fg = '#599EFF' })

require('mini.surround').setup({
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

require('mini.comment').setup()

require('mini.move').setup()

require('mini.files').setup()

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
    highlighters = {
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

require('mini.sessions').setup({
    file = '',
    directory = vim.fn.stdpath('data') .. '/sessions',
    autowrite = true,
})

