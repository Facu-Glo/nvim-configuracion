return {
    {
        "A7Lavinraj/fyler.nvim",
        dependencies = { "nvim-mini/mini.icons" },
        branch = "stable",
        opts = {
            hooks = {
                on_highlight = function(highlight_groups, _)
                    highlight_groups.FylerFSDirectoryIcon = { fg = "#89b4fa" }
                    highlight_groups.FylerFSDirectoryName = { fg = "#89b4fa", bold = true }

                    highlight_groups.FylerGitModified = { fg = "#fab387" }
                    highlight_groups.FylerGitAdded = { fg = "#a6e3a1" }
                    highlight_groups.FylerGitUntracked = { fg = "#6d6d6d" }

                    highlight_groups.FylerIndentMarker = { fg = "#45475a" }
                end
            },
            views = {
                finder = {
                    follow_current_file = true,
                    icon = {
                        directory_expanded = ""
                    },
                    mappings = {
                        ["q"] = "CloseView",
                        ["<CR>"] = "Select",
                        ["L"] = "Select",
                        ["<C-t>"] = "SelectTab",
                        ["|"] = "SelectVSplit",
                        ["-"] = "SelectSplit",
                        ["^"] = "GotoParent",
                        ["="] = "GotoCwd",
                        ["."] = "GotoNode",
                        ["#"] = "CollapseAll",
                        ["<BS>"] = "CollapseNode",
                    },
                    win = {
                        kind = "split_right_most",
                        border = "single",
                        kinds = {
                            split_right_most = {
                                width = "25%",
                            },
                            float = {
                                width = "70%",
                                height = "70%",
                            }
                        },
                        win_opts = {
                            number = true,
                            relativenumber = true,
                            cursorline = false,
                            signcolumn = "yes",
                        }
                    },
                },
            },
        }
    },
}
