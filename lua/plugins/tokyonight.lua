vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim.git", version = "main" },
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
    on_highlights = function(highlights, _)
        highlights.ColorColumn = { bg = "#2c2e34" }

        highlights.MiniTablineFill = { bg = "NONE" }

        highlights.MiniTablineCurrent = {
            bg = "#3a4261",
            fg = "#c0caf5",
            underline = true,
            sp = "#7aa2f7",
            bold = true,
        }

        highlights.MiniTablineModifiedCurrent = {
            bg = "#3a4261",
            fg = "#5BCFB1",
            underline = true,
            sp = "#5BCFB1",
            bold = true,
        }

        highlights.MiniTablineModified = {
            fg = "#5BCFB1",
            bg = "NONE",
        }
        highlights.MiniTablineModifiedVisible = {
            fg = "#5BCFB1",
            bg = "NONE",
        }
        highlights.MiniTablineModifiedHidden = {
            fg = "#5BCFB1",
            bg = "NONE",
        }
    end,
})

vim.cmd.colorscheme("tokyonight")
