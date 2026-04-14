vim.api.nvim_set_hl(0, "YankHighlight", {
    fg = "#1e1e2e",
    bg = "#f18e5d",
    bold = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Resaltar texto al copiar (yank)",
    callback = function()
        vim.highlight.on_yank({
            higroup = "YankHighlight",
            timeout = 200,
        })
    end,
})
