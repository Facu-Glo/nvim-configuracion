vim.api.nvim_set_hl(0, "YankHighlight", {
    fg = "#1e1e2e",
    bg = "#f18e5d",
    bold = true,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "markdown_inline" },
    desc = "Desactivar números de línea en Markdown",
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
    end,
})
