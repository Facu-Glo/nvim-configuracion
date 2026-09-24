vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim.git", version = "main" },
})

require("snacks").setup({
    dashboard = {
        enabled = true,
        width = 72,
        preset = {},
        sections = {
            { section = "header" },
            {
                align = "center",
                padding = 1,
                text = {
                    { "  Update[u]  ", hl = "Label" },
                    { "  Session[s]  ", hl = "@property" },
                    { "  Quit[q]  " },
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
                    require("persistence").load()
                end
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
                limit = 3,
            },
            {
                pane = 1,
                section = "recent_files",
                title = "Most Recent Files:",
                icon = " ",
                indent = 2,
                padding = 1,
                limit = 4,
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
    notifier = { enabled = false },
    scroll = { enabled = true },
    lazygit = {
        enabled = true,
        win = {
            border = "rounded"
        }
    },
    statuscolumn = { enabled = true },
    picker = {
        enabled = true,
        sources = {
            explorer = {
                layout = { layout = { position = "right" } },
            }
        }
    },
})

------------------------------------------------------------------------------------------------

-- [ SNACKS ]
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fn", function() Snacks.picker.notifications() end, { desc = "History" })
vim.keymap.set("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Help" })
vim.keymap.set("n", "<leader>fz", function() Snacks.picker.zoxide() end, { desc = "Zoxide" })
vim.keymap.set("n", "<leader>fl", function() Snacks.picker.lines() end, { desc = "Buscar lineas" })
vim.keymap.set("n", "<leader>f:", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>fd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostico" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.registers() end, { desc = "Registros" })
vim.keymap.set("n", "<leader>fu", function() Snacks.picker.undo() end, { desc = "Undo" })
vim.keymap.set("n", "<leader>fi", function() Snacks.picker.icons() end, { desc = "Icons" })
vim.keymap.set("n", "<leader>fs", function() Snacks.picker.lsp_symbols() end, { desc = "Lsp symbols" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.colorschemes() end, { desc = "colorscheme" })
vim.keymap.set("n", "<leader>fm", function() Snacks.picker.marks() end, { desc = "Marks" })

-- Git
vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })

-- Buffers & Utils
vim.keymap.set("n", "<leader>bc", function() Snacks.bufdelete() end, { desc = "Eliminar buffer" })
vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Eliminar otros" })
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })

-- Terminal
vim.keymap.set("n", "<leader>ts", function()
    Snacks.terminal.toggle(nil, {
        cwd = vim.fn.getcwd(),
        win = {
            position = "bottom",
            height = 0.5,
            keys = {
                ["<M-q>"] = { "hide", mode = { "n", "t" } },
            },
        },
    })
end, { desc = "Terminal split horizontal" })

vim.keymap.set("n", "<leader>tv", function()
    Snacks.terminal.toggle("zsh", {
        win = {
            position = "right",
            width = 0.5,
            keys = {
                ["<M-q>"] = { "hide", mode = { "n", "t" } },
            },
        },
    })
end, { desc = "Terminal split vertical" })
