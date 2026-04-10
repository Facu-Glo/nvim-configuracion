vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim.git", version = "main" }
})

require("snacks").setup({
    dashboard = {
        enabled = true,
        width = 72,
        preset = {
            header = [[
██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗  █████╗ ██████╗ ██████╗
██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔══██╗
██║  ██║███████║███████╗███████║██████╔╝██║   ██║███████║██████╔╝██║  ██║
██║  ██║██╔══██║╚════██║██╔══██║██╔══██╗██║   ██║██╔══██║██╔══██╗██║  ██║
██████╔╝██║  ██║███████║██║  ██║██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝]],
        },
        sections = {
            { section = "header" },
            {
                align = "center",
                padding = 1,
                text = {
                    { "  Update[u] ", hl = "Label" },
                    { "  Session[s] ", hl = "@property" },
                    { "  Find Files[f] ", hl = "DiagnosticInfo" },
                    { " 󰱼 Find Text[g] ", hl = "DiagnosticHint" },
                    { "  Quit[q] ", hl = "Error" },
                },
            },

            {
                icon = "",
                key = "q",
                action = ":qa",
                hidden = true
            },
            {
                icon = "",
                key = "s",
                hidden = true,
                action = function()
                    local session_name = vim.fn.getcwd():gsub("/", "%%")
                    require("mini.sessions").read(session_name)
                end
            },
            {
                icon = "",
                key = "f",
                action = function() Snacks.picker.files() end,
                hidden = true
            },
            {
                icon = "",
                key = "g",
                action = function() Snacks.picker.grep() end,
                hidden = true
            },
            {
                icon = "",
                key = "u",
                action = ":lua vim.pack.update()",
                hidden = true
            },

            {
                pane = 1,
                section = "projects",
                title = "Recent Projects:",
                icon = "󰉋 ",
                indent = 2,
                padding = 1,
                limit = 5,
            },
            {
                pane = 1,
                section = "recent_files",
                title = "Most Recent Files:",
                icon = " ",
                indent = 2,
                padding = 1,
                limit = 6,
            },

            {
                text = {
                    {
                        "Version " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version()
                        .patch,
                        hl = "SnacksDashboardFooter",
                        align = "center",
                    },
                },
                padding = 1,
            },
        },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    scroll = { enabled = true },
    lazygit = { enabled = true },
    statuscolumn = { enabled = true },
    picker = {
        enabled = true,
        sources = {
            explorer = {
                hidden = true,
                layout = { layout = { position = "right", width = 40 } },
            },
            files = { hidden = false }
        },
        layout = {
            preset = "ivy",
            cycle = false,
        },
        layouts = {
            default = {
                layout = {
                    box = "horizontal",
                    width = 0.8,
                    min_width = 120,
                    height = 0.8,
                    {
                        box = "vertical",
                        border = "rounded",
                        title = "{title} {live} {flags}",
                        { win = "input", height = 1,     border = "bottom" },
                        { win = "list",  border = "none" },
                    },
                    { win = "preview", title = "{preview}", border = "rounded", width = 0.5 },
                },
            },
            ivy = {
                layout = {
                    box = "vertical",
                    backdrop = false,
                    row = -1,
                    width = 0,
                    height = 0.5,
                    border = "top",
                    title = " {title} {live} {flags}",
                    title_pos = "left",
                    { win = "input", height = 1, border = "bottom" },
                    {
                        box = "horizontal",
                        { win = "list",    border = "none" },
                        { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                    },
                },
            },
        },
        win = {
            input = {
                keys = {
                    ["<M-t>"] = { "tab", mode = { "n", "i" } },
                }
            },
        }
    },
})
