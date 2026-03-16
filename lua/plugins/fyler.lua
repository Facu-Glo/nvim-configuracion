local function open_files()
    local line = vim.api.nvim_get_current_line()
    local filename = line:match("([^%s%z]+)$")

    if filename then
        local name_lower = filename:lower()
        if name_lower:match("%.pdf$") or name_lower:match("%.png$") or
            name_lower:match("%.jpg$") or name_lower:match("%.jpeg$") then
            local full_path = vim.fn.getcwd() .. "/" .. filename

            if vim.fn.filereadable(full_path) == 1 then
                vim.fn.jobstart({ "xdg-open", full_path }, { detach = true })
                print("Abriendo externo: " .. filename)
                return
            end
        end
    end

    local key = vim.api.nvim_replace_termcodes("<F24>", true, false, true)
    vim.api.nvim_feedkeys(key, "m", false)
end

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
                end,
            },
            views = {
                finder = {
                    follow_current_file = true,
                    close_on_select = false,
                    icon = {
                        directory_expanded = "",
                    },
                    mappings = {
                        ["q"]     = "CloseView",
                        ["<CR>"]  = open_files,
                        ["<F24>"] = "Select",
                        ["L"]     = "Select",
                        ["<C-t>"] = "SelectTab",
                        ["|"]     = "SelectVSplit",
                        ["-"]     = "SelectSplit",
                        ["^"]     = "GotoParent",
                        ["H"]     = "GotoParent",
                        ["="]     = "GotoCwd",
                        ["."]     = "GotoNode",
                        ["#"]     = "CollapseAll",
                        ["<BS>"]  = "CollapseNode",
                    },
                    win = {
                        kind = "split_right_most",
                        border = "single",
                        kinds = {
                            split_right_most = {
                                width = "30%",
                            },
                            float = {
                                width = "70%",
                                height = "70%",
                            }
                        },
                        win_opts = {
                            number = true,
                            relativenumber = true,
                            cursorline = true,
                            signcolumn = "yes",
                        }
                    },
                },
            },
        }
    },
}
