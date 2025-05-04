return {
    {
        'b0o/incline.nvim',
        event = 'VeryLazy',
        config = function()
            require('incline').setup({
                hide = {
                    only_win = true,
                },
                highlight = {
                    groups = {
                        InclineNormal = { guibg = "#5162a1", guifg = "#ffffff" },
                        InclineNormalNC = { guibg = "#5f6168", guifg = "#000000" },
                    }
                }
            })
        end,
    },
}
