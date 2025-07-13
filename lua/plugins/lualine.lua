return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "folke/noice.nvim",
        },
        config = function()
            local noice = require("noice")
            require("mini.icons").mock_nvim_web_devicons()

            local funcs = require("plugins.config.lualine_functions")

            vim.api.nvim_set_hl(0, "LualineFilename", { fg = "#e7e7e7", bold = true })
            vim.api.nvim_set_hl(0, "MacroRecording", { fg = "#f88044", bold = true })

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 100,
                        tabline = 100,
                        winbar = 100,
                    },
                },
                sections = {
                    lualine_a = {
                        -- {
                        --     "mode",
                        --     color = { gui = "bold" },
                        -- }
                        {
                            funcs.custom_mode,
                            color = { gui = "bold" },
                        }
                    },
                    lualine_b = { "branch", "diff" },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = " ",
                                warn  = " ",
                            }
                        },
                        funcs.pretty_path,
                    },
                    lualine_x = {
                        -- -- Muestra las teclas que se presionan
                        -- {
                        --     noice.api.status.command.get,
                        --     cond = noice.api.status.command.has,
                        --     color = { fg = "#ff9e64" },
                        -- },
                        --
                        -- COPILOT SIN PLUGIN
                        {
                            function()
                                for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                                    if client.name == "copilot" then
                                        return " "
                                    end
                                end
                                return " "
                            end,
                            color = function()
                                for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                                    if client.name == "copilot" then
                                        return { fg = "#37d5ff", gui = "bold" }
                                    end
                                end
                                return { fg = "#6272A4", gui = "bold" }
                            end,
                        },

                        -- {
                        --     'copilot',
                        --     symbols = {
                        --         status = {
                        --             icons = {
                        --                 enabled = " ",
                        --                 sleep = " ",
                        --                 disabled = " ",
                        --                 warning = " ",
                        --                 unknown = " "
                        --             },
                        --             hl = {
                        --                 enabled = "#37d5ff",
                        --                 sleep = "#AEB7D0",
                        --                 disabled = "#6272A4",
                        --                 warning = "#FFB86C",
                        --                 unknown = "#FF5555"
                        --             }
                        --         },
                        --         spinners = "dots",
                        --         spinner_color = "#6272A4"
                        --     },
                        --     show_colors = true,
                        --     show_loading = true
                        -- },
                        {
                            noice.api.status.mode.get,
                            cond = noice.api.status.mode.has,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            noice.api.status.search.get,
                            cond = noice.api.status.search.has,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            -- "lsp_status",
                            -- icon = " ",
                            -- symbols = {
                            --     spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                            --     done = "✓",
                            --     separator = " ",
                            -- },

                            "filetype",
                            icon_only = false,
                            separator = "|",
                            padding   = {
                                left  = 1,
                                right = 1,
                            },
                            color     = {
                                fg = "#ffffff",
                            },
                        },

                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
}
