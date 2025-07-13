return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern",
        spec = {
            {
                mode = { "n", "v" },
                { "<leader>t", group = "terminal / to do" },
                { "<leader>c", group = "code" },
                { "<leader>d", group = "debug" },
                { "<leader>f", group = "file/find" },
                { "<leader>g", group = "git" },
                { "<leader>q", group = "quit/session" },
                { "<leader>s", group = "search" },
                -- { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
                { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
                { "[", group = "prev" },
                { "]", group = "next" },
                { "g", group = "goto" },
                { "gs", group = "surround" },
                { "z", group = "fold" },
                {
                    "<leader>b",
                    group = "buffer",
                    expand = function()
                        return require("which-key.extras").expand.buf()
                    end,
                },
                {
                    "<leader>w",
                    group = "windows",
                    proxy = "<c-w>",
                    expand = function()
                        return require("which-key.extras").expand.win()
                    end,
                },
                { "gx", desc = "Open with system app" },

                { "<leader>m", name = "Multicursores", icon = { icon = "󰇀", color = "grey" } },
                { "<leader>r", name = "Relative number", icon = { icon = " " } },
                { "<leader>o", name = "Abir Oil explorer", icon = { icon = "󰝰 " } },
                { "<leader>i", name = "Copilot", icon = { icon = " ", color = "blue" } },
            },
        },
    },
}
