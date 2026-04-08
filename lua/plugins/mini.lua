vim.pack.add({
    { src = "https://github.com/echasnovski/mini.nvim.git", version = "main" }
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

local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = { 'n', 'x' }, keys = '<Leader>' },

        -- `[` and `]` keys
        { mode = 'n',          keys = '[' },
        { mode = 'n',          keys = ']' },

        -- Built-in completion
        { mode = 'i',          keys = '<C-x>' },

        -- `g` key
        { mode = { 'n', 'x' }, keys = 'g' },

        -- Marks
        { mode = { 'n', 'x' }, keys = "'" },
        { mode = { 'n', 'x' }, keys = '`' },

        -- Registers
        { mode = { 'n', 'x' }, keys = '"' },
        { mode = { 'i', 'c' }, keys = '<C-r>' },

        -- Window commands
        { mode = 'n',          keys = '<C-w>' },

        -- `z` key
        { mode = { 'n', 'x' }, keys = 'z' },
    },
    window = {
        delay = 200,

        config = {
            border = 'rounded',
        },
    },
    clues = {
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})
-- require('mini.pairs').setup()

require('mini.sessions').setup({
    file = '',
    directory = vim.fn.stdpath('data') .. '/sessions',
    autowrite = true,
})
