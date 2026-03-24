local function open_files()
    local line = vim.api.nvim_get_current_line()
    local filename = line:match("([^%s%z]+)$")

    if filename then
        local cmd = string.format("fd -g '%s' --max-results 1", filename)
        local handle = io.popen(cmd)

        if handle then
            local result = handle:read("*a")
            handle:close()

            if result and result ~= "" then
                local relative_path = result:gsub("%s+$", "")
                local full_path = vim.fn.getcwd() .. "/" .. relative_path

                vim.fn.jobstart({ "xdg-open", full_path }, { detach = true })
                print("Open: " .. relative_path)
                return
            end
        end
        print("fd no encontró: " .. filename)
    end
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
                        ["<M-o>"] = open_files,
                    },
                    win = {
                        kind = "split_right_most",
                        border = "single",
                        kinds = {
                            split_right_most = {
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
                        }
                    },
                },
            },
        }
    },
}
