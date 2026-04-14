vim.pack.add({
    { src = "https://github.com/folke/noice.nvim.git" },
    { src = "https://github.com/rcarriga/nvim-notify.git" },
    { src = "https://github.com/MunifTanjim/nui.nvim.git" },
})

local notify = require("notify")
notify.setup({
    background_colour = "#000000",
    render = "compact",
    stages = "static",
})
vim.notify = notify

require("noice").setup({
    views = {
        cmdline_popup = {
            position = { row = 2, col = "50%" },
            size = { width = 60, height = "auto" },
            border = { style = "rounded" },
        },
    },
    cmdline = {
        enabled = true,
        view = "cmdline",
        format = {
            search_down = { view = "cmdline" },
            search_up = { view = "cmdline" },
        },
    },
    messages = {
        enabled = true,
    },
    lsp = {
        progress = {
            enabled = false,
        },
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
        },
        hover = { enabled = true },
    },
    presets = {
        lsp_doc_border = true,
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
    },
    status = {
    },
})
