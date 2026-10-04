vim.pack.add({
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})
require('render-markdown').setup({
    enabled = false,
    heading = {
        width = 'block',
        left_pad = 2,
        right_pad = 4,
    },
    dash = { width = 30 },
    code = {
        width = 'block',
        sign = false,
        left_pad = 2,
        right_pad = 4,
    },

})
