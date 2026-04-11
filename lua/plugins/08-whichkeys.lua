vim.pack.add({ { src = "https://github.com/folke/which-key.nvim.git" } })

require("which-key").setup({
    preset = "modern",
    spec = {
        {
            mode = { "v", "n" },
            { "<leader>c", group = "code" },
            { "<leader>g", group = "git" },
            { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
            { "<leader>b", group = "buffer", },
            { "<leader>m", group = "Multicursores", icon = { icon = "󰇀", color = "grey" } },
            { "<leader>q", group = "quit/session" },
            { "<leader>f", group = "file/find" },
            { "<leader>t", group = "terminal" },
            { "<leader>r", name = "Toggle números relativos", icon = { icon = " " } },
        }
    }
})
