return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",

    config = function()
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
                globalstatus = true,
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
                        function()
                            return funcs.get_macro_recording_status()
                        end,
                        cond = function()
                            return vim.fn.reg_recording() ~= ""
                        end,
                    },

                    "fileformat",

                    {
                        "lsp_status",
                        icon = " ", -- f013
                        symbols = {
                            -- Standard unicode symbols to cycle through for LSP progress:
                            spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                            -- Standard unicode symbol for when LSP is done:
                            done = "✓",
                            -- Delimiter inserted between LSP names:
                            separator = " ",
                        },
                        -- List of LSP names to ignore (e.g., `null-ls`):
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
