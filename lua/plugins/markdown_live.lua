return {
    "iamcco/markdown-preview.nvim",

    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
        require("lazy").load({ plugins = { "markdown-preview.nvim" } })
        vim.fn["mkdp#util#install"]()
    end,
    keys = {
        {
            "<leader>pm",
            ft = "markdown",
            "<cmd>MarkdownPreview<cr>",
            desc = "Markdown Preview",
        },
        {
            "<leader>ps",
            ft = "markdown",
            "<cmd>MarkdownPreviewStop<cr>",
            desc = "Markdown stop Preview",
        },
    },
    config = function()
        vim.cmd([[do FileType]])
    end,
}

--- en ~/.local/share/nvim-prueba/lazy/markdown-preview.nvim/app instalar tslib con npm
