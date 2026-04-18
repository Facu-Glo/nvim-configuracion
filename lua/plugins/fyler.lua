vim.pack.add({
    { src = "https://github.com/A7Lavinraj/fyler.nvim.git", version = "main" },
})

require("fyler").setup({
    hooks = {
        on_highlight = function(highlight_groups, _)
            -- Colores para directorios (usando el azul de Catppuccin/Tokyo)
            highlight_groups.FylerFSDirectoryIcon = { fg = "#89b4fa" }
            highlight_groups.FylerFSDirectoryName = { fg = "#89b4fa", bold = true }

            -- Colores de Git
            highlight_groups.FylerGitModified = { fg = "#fab387" }
            highlight_groups.FylerGitAdded = { fg = "#a6e3a1" }
            highlight_groups.FylerGitUntracked = { fg = "#6d6d6d" }

            -- Marcadores de indentación
            highlight_groups.FylerIndentMarker = { fg = "#45475a" }
        end,
    },
    views = {
        finder = {
            follow_current_file = true,
            close_on_select = false,
            columns_order = { "git", "link", "diagnostic" },
            icon = {
                directory_expanded = "",
            },
            mappings = {
                ["q"]     = "CloseView",
                ["<CR>"]  = "Select",
                ["L"]     = "Select",
                ["<C-t>"] = "SelectTab",
                ["|"]     = "SelectVSplit",
                ["_"]     = "SelectSplit",
                ["^"]     = "GotoParent",
                ["H"]     = "GotoParent",
                ["="]     = "GotoCwd",
                ["."]     = "GotoNode",
                ["#"]     = "CollapseAll",
                ["<BS>"]  = "CollapseNode",
                ["-"]     = "CloseView",
            },
            win = {
                kind = "split_right_most",
                border = "single",
                kinds = {
                    split_right_most = {
                        width = "28%",
                    },
                    split_left_most = {
                        width = "28%",
                    },
                    float = {
                        width = "70%",
                        height = "70%",
                    },
                    split_below_all = {
                        height = "35%",
                    },
                },
                win_opts = {
                    number = true,
                    relativenumber = true,
                    cursorline = true,
                    signcolumn = "yes",
                },
            },
        },
    },
})

------------------------------------------------------------------------------------------------
vim.keymap.set({ "n", "v" }, "-", function()
    require("fyler").toggle({ kind = "float" })
end, { desc = "Abrir Fyler" })
