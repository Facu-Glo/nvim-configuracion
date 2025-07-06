return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    keys = {
        {
            "<leader>pm",
            "<cmd>MarkdownPreview<cr>",
            desc = "Markdown Start Preview",
        },
        {
            "<leader>ps",
            "<cmd>MarkdownPreviewStop<cr>",
            desc = "Markdown Stop Preview",
        },
    },
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>p", icon = "", group = "Markdown Preview" },
        })
    end,
}
