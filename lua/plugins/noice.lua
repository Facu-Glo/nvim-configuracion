return {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
        require("noice").setup({
            views = {
                cmdline_popup = {
                    position = {
                        row = 2,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                    border = {
                        style = "rounded",
                    },
                },
            },
            cmdline = {
                view = "cmdline",
            },

        })
    end,
    dependencies = {
        "rcarriga/nvim-notify",
    },
}
