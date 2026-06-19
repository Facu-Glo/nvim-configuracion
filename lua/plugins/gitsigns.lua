vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim.git" },
})

require('gitsigns').setup {
    signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
    },
    signs_staged = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
    },
    signs_staged_enable = true,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
    },
    current_line_blame_formatter = function(name, blame_info)
        local blame_formatter = require('gitsigns.blame_formatter')
        local text = blame_formatter.expand_string(
            '   <author>, <author_time:%R>',
            name,
            blame_info,
            { self_author_text = 'Facu' }
        )
        return {{ text, 'GitSignsCurrentLineBlame' }}
    end,
    preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
}

