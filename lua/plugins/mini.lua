return {
    "echasnovski/mini.nvim",
    config = function()
        require('mini.surround').setup({
            mappings = {
                add = 'gsa',            -- Add surrounding in Normal and Visual modes
                delete = 'gsd',         -- Delete surrounding
                find = 'gsf',           -- Find surrounding (to the right)
                find_left = 'gsF',      -- Find surrounding (to the left)
                highlight = 'gsh',      -- Highlight surrounding
                replace = 'gsr',        -- Replace surrounding
                update_n_lines = 'gsn', -- Update `n_lines`

                suffix_last = 'l',      -- Suffix to search with "prev" method
                suffix_next = 'n',      -- Suffix to search with "next" method
            },

        })

        require('mini.icons').setup({
            extension = {
                c = { glyph = '', hl = 'CIconHL' },
            },
        })
        vim.api.nvim_set_hl(0, 'CIconHL', { fg = '#599EFF' })

        require('mini.comment').setup()
        require('mini.move').setup()
        require('mini.pairs').setup()
        require('mini.files').setup()

        local hipatterns = require('mini.hipatterns')
        hipatterns.setup({
            highlighters = {
                -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

                -- Highlight hex color strings (`#rrggbb`) using that color
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })
    end
}
