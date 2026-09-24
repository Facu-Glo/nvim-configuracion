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

sessions.setup({
    directory = vim.fn.stdpath('state') .. '/sessions',
    autowrite = false,
    autoread = false,
    file = '',
})
require("config.sessions").setup()
