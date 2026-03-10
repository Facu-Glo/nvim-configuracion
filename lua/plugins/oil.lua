return {
    {
        "A7Lavinraj/fyler.nvim",
        dependencies = { "nvim-mini/mini.icons" },
        branch = "stable",
        opts = {
            views = {
                explorer = {
                    width = 0.2,
                    height = 0.2,
                    kind = "split:rightmost",
                    border = "single",
                },
                confirm = {
                    width = 0.5,
                    height = 0.4,
                    kind = "float",
                    border = "single",
                },
            },
        }
    },
}
