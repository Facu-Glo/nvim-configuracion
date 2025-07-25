return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
        require('render-markdown').setup({
            completions = {
                blink = { enabled = true },
                lsp = { enabled = false },
            },
            file_types = { 'markdown', 'copilot-chat' },
            checkbox = { checked = { scope_highlight = '@markup.strikethrough' } },
            heading = { border = true },
            pipe_table = { preset = 'round' },
        })
    end
}
