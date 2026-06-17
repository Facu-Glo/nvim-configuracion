vim.pack.add({
    { src = "https://github.com/FylerOrg/fyler.nvim", version = "main" },
})

require("fyler").setup({
    follow_current_file = true,
    kind = "split_right_most",
    integrations = { icon = "mini_icons" },
    extensions = {
        git = { enabled = true },
    },
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
    kind_presets = {
        split_right_most = { width = "28%" },
        split_left_most = { width = "28%" },
        float = {
            width = "70%",
            height = "70%",
            border = "single",
        },
        split_below_all = { height = "35%" },
    },
    win_opts = {
        number = true,
        relativenumber = true,
        cursorline = true,
        signcolumn = "yes",
    },
    mappings = {
        n = {
            ["q"]     = { action = "close" },
            ["<CR>"]  = { action = "select" },
            ["L"]     = { action = "select" },
            ["<C-t>"] = { action = "select", args = { tabedit = true } },
            ["|"]     = { action = "select", args = { vsplit = true } },
            ["-"]     = { action = "select", args = { split = true } },
            ["^"]     = { action = "visit", args = { parent = true } },
            ["H"]     = { action = "visit", args = { parent = true } },
            ["="]     = { action = "visit" },
            ["."]     = { action = "visit", args = { cursor = true } },
            ['g.']    = { action = 'toggle_ui', args = { 'hidden_items' } },
            ['gi']    = { action = 'toggle_ui', args = { 'indent_guides' } },
            ["<BS>"]  = { action = "shrink", args = { parent = true } },
        },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>o", function()
    require("fyler").open({ kind = "floating" })
end, { desc = "Abrir Fyler" })
