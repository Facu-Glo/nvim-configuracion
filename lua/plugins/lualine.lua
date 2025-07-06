return {
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
                    {
                        "filetype",
                        icon_only = true,
                        separator = "",
                        padding   = {
                            left  = 2,
                            right = 0,
                        }
                    },
                    funcs.pretty_path,
                    -- {
                    --     function()
                    --         local navic = require("nvim-navic")
                    --         return navic.is_available() and navic.get_location() or ""
                    --     end,
                    --     cond = function()
                    --         return require("nvim-navic").is_available()
                    --     end,
                    -- }
                },
                lualine_x = {
                    {
                        noice.api.status.command.get,
                        cond = noice.api.status.command.has,
                        color = { fg = "#ff9e64" },
                    },
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
                        "lsp_status",
                        icon = " ", -- f013
                        symbols = {
                            spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                            done = "✓",
                            separator = " ",
                        },
                        ignore_lsp = {},
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
}
