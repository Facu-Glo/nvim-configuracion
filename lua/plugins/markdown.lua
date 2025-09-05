return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require('render-markdown').setup({
            completions = {
                blink = { enabled = true },
                lsp = { enabled = false },
            },
            file_types = { 'markdown', 'copilot-chat' },
            checkbox = { checked = { scope_highlight = '@markup.strikethrough' } },
            heading = { border = false },
            pipe_table = { preset = 'round' },
            code = {
                position = 'right',
                width = 'block',
                left_pad = 2,
                right_pad = 4,
            },
        })
    end
}
