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
            { "<leader>m", name = "Multicursores", icon = { icon = "󰇀", color = "grey" } },
            { "<leader>r", name = "Toggle números relativos", icon = { icon = " " } },
            { "<leader>f", group = "file/find" },
        }
    }
})
