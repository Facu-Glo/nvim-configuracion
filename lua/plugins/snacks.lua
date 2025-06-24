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
            "<leader>fz",
            function()
                Snacks.picker.zoxide()
            end,
            desc = "Buscar directorios",
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
