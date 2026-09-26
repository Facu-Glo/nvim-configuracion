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
local sessions = require('mini.sessions')
local clue = require('mini.clue')

surround.setup()
pairs.setup()
comment.setup()
move.setup()
jump.setup()
jump2d.setup()
icons.setup({
    extension = {
        c = { glyph = '', hl = 'CIconHL' },
    },
})
icons.mock_nvim_web_devicons()

vim.api.nvim_set_hl(0, 'CIconHL', { fg = '#599EFF' })

hipatterns.setup({
    highlighters = {
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

require("config.ui.tabline").setup(tabline)

sessions.setup({
    directory = vim.fn.stdpath('state') .. '/sessions',
    autowrite = false,
    autoread = false,
    file = '',
})
require("config.sessions").setup()

clue.setup({
    triggers = {
        { mode = { 'n', 'x' }, keys = '<Leader>' },

        { mode = 'n',          keys = '<C-w>' },

        { mode = { 'n', 'x' }, keys = 'g' },
        { mode = { 'n', 'x' }, keys = 'z' },

        { mode = 'n',          keys = '[' },
        { mode = 'n',          keys = ']' },

        { mode = { 'n', 'x' }, keys = "'" },
        { mode = { 'n', 'x' }, keys = '`' },
        { mode = { 'n', 'x' }, keys = '"' },
        { mode = { 'i', 'c' }, keys = '<C-r>' },

        { mode = 'i',          keys = '<C-x>' },
    },

    clues = {
        { mode = { 'n', 'x' }, keys = '<Leader>b', desc = '+Buffers' },
        { mode = { 'n', 'x' }, keys = '<Leader>c', desc = '+Code' },
        { mode = { 'n', 'x' }, keys = '<Leader>d', desc = '+Debug / DAP' },
        { mode = { 'n', 'x' }, keys = '<Leader>f', desc = '+File / Find' },
        { mode = { 'n', 'x' }, keys = '<Leader>g', desc = '+Git' },
        { mode = { 'n', 'x' }, keys = '<Leader>q', desc = '+Quit' },
        { mode = { 'n', 'x' }, keys = '<Leader>t', desc = '+Terminal' },
        { mode = { 'n', 'x' }, keys = '<Leader>x', desc = '+Trouble / Diag' },

        clue.gen_clues.builtin_completion(),
        clue.gen_clues.g(),
        clue.gen_clues.marks(),
        clue.gen_clues.registers(),
        clue.gen_clues.windows(),
        clue.gen_clues.z(),
        clue.gen_clues.square_brackets(),
    },

    window = {
        delay = 300,
        config = {
            width = "50",
            border = "rounded",
        }
    },
})
