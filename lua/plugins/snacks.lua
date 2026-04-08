vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim.git", version = "main" }
})

require("snacks").setup({
    dashboard = {
        enabled = true,
        preset = {
            keys = {
                { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                {
                    icon = " ",
                    key = "s",
                    desc = "Restore Session",
                    action = function()
                        local session_name = vim.fn.getcwd():gsub("/", "%%")
                        require("mini.sessions").read(session_name)
                    end
                },
                { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
        },
        sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
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
