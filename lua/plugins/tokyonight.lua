vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim.git",    version = "main" },
})

require("tokyonight").setup({
    transparent = true,
    styles = {
        sidebars = "transparent",
        floats = "transparent",
    },
    on_colors = function(colors)
        colors.bg_statusline = colors.none
    end,
})

vim.cmd.colorscheme("tokyonight")

