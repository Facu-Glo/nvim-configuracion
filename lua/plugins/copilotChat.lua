return {
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua", },
            { "nvim-lua/plenary.nvim",  branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            window = {
                layout = "vertical",
                width = 0.35,
            },
            show_help = true,
        },
    },
}
