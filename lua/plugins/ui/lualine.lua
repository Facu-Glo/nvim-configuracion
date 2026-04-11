local has_icons, mini_icons = pcall(require, "mini.icons")
if has_icons then
    mini_icons.mock_nvim_web_devicons()
end

local has_funcs, funcs = pcall(require, "plugins.functions.lualine_functions")
if not has_funcs then
    funcs = { custom_mode = "mode", pretty_path = "filename" }
end

local noice = require("noice")
--- ----------------

vim.api.nvim_set_hl(0, "LualineFilename", { fg = "#e7e7e7", bold = true })
vim.api.nvim_set_hl(0, "MacroRecording", { fg = "#f88044", bold = true })

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = { "NvimTree", "dashboard", "alpha", "ministarter", "snacks_dashboard", "fyler" }
        },
        globalstatus = false,
    },
    sections = {
        lualine_a = {
            { funcs.custom_mode, color = { gui = "bold" } }
        },
        lualine_b = { "branch", "diff" },
        lualine_c = {
            { "diagnostics", symbols = { error = " ", warn = " " } },
            funcs.pretty_path,
        },
        lualine_x = {
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
                "filetype",
                icon_only = false,
                separator = "|",
                color = { fg = "#ffffff" },
            },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})

