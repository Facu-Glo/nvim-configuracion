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
        view = "cmdline",
        format = {
            search_down = { view = "cmdline" },
            search_up = { view = "cmdline" },
        },
    },
    lsp = {
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
