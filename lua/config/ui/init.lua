require("config.ui.ui2")
require("config.ui.statusline").setup({
    mode_style     = "bar",
    mode_separator = "",
    git_separator  = "",

    layout         = {
        left = {
            "mode",
            "git",
            "path"
        },

        right = {
            "diag",
            "search",
            "macro",
            "lsp",
            "filetype"
        },
    },
})

