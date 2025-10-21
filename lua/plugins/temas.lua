return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    },
    {
        'Everblush/nvim',
        name = 'everblush',
        opts = {
            transparent_background = true,
            override = {
                CursorLineNr = { fg = '#E0833A', bold = true },
                LineNr = { fg = '#3B3939', bold = true },

                SnacksIndent = { fg = "#3B3939" },
                SnacksIndentScope = { fg = "#4ABEE8" },
            },
        }
    },
}
