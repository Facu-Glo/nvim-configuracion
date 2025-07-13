return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- bigfile = { enabled = true },
        dashboard = {
            enabled = true,

            sections = {
                { section = "header" },
                { section = "keys",  gap = 1, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    title = "Recent Files",
                    section = "recent_files",
                    indent = 2,
                    padding = 1,
                },
                { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    title = "Git Status",
                    section = "terminal",
                    enabled = function()
                        return Snacks.git.get_root() ~= nil
                    end,
                    -- cmd = "hub status --short --branch --renames",
                    cmd = "git status --short --branch --renames",
                    height = 5,
                    padding = 1,
                    ttl = 5 * 60,
                    -- ttl = 0,
                    indent = 3,
                },
                { section = "startup" },
            },
            preset = {
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
                header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
            },
        },
        explorer = {
            enabled = true,
        },
        indent = { enabled = true },
        input = { enabled = true },
        -- input = { enabled = true },
        picker = {
            enabled = true,
            sources = {
                explorer = {
                    hidden = true,
                    layout = {
                        layout = {
                            position = "left",
                            -- width = 30,
                        },
                    },
                },
                files = {
                    hidden = true,

                }
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
        notifier = { enabled = true },
        -- quickfile = { enabled = true },
        -- scope = { enabled = true },
        scroll = { enabled = true },
        lazygit = { enabled = true },
        statuscolumn = { enabled = true },
        -- words = { enabled = true },
    },
    keys = {
        {
            "<leader><space>",
            function()
                Snacks.picker.files()
            end,
            desc = "Buscar archivos",
        },
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>fn",
            function()
                Snacks.picker.notifications()
            end,
            desc = "Notification History",
        },
        {
            "<leader>fh",
            function()
                Snacks.picker.help()
            end,
            desc = "Help",
        },
        {
            "<leader>fz",
            function()
                Snacks.picker.zoxide()
            end,
            desc = "Buscar directorios",
        },
        {
            "<leader>fl",
            function()
                Snacks.picker.lines()
            end,
            desc = "Buscar lineas",
        },
        {
            "<leader>f:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>fd",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Diagnostico",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.registers()
            end,
            desc = "Registros",
        },
        {
            "<leader>fu",
            function()
                Snacks.picker.undo()
            end,
            desc = "Undo",
        },
        {
            "<leader>bd",
            function()
                Snacks.bufdelete()
            end,
            desc = "Eliminar buffer",
        },
        {
            "<leader>bo",
            function()
                Snacks.bufdelete.other()
            end,
            desc = "Eliminar otros buffers",
        },
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "File Explorer",
        },
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<leader>gb",
            function()
                Snacks.picker.git_branches()
            end,
            desc = "Git Branchs",
        },
        {
            "<leader>gl",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Git Log",
        },
        {
            "<leader>tt",
            function()
                Snacks.terminal.toggle(nil, { cwd = vim.fn.getcwd() })
            end,
            desc = "Terminal horizontal",
            mode = { "n", "t" }
        },
        {
            "<leader>ty",
            function()
                Snacks.terminal(nil, { win = { position = 'float' } })
            end,
            desc = "Terminal flotante",
            mode = { "n", "t" }
        },
        {
            "<leader>cs",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "Lsp symbols"
        }
    },
}
