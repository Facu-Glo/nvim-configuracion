vim.api.nvim_set_hl(0, "YankHighlight", {
    fg = "#1e1e2e",
    bg = "#f18e5d",
    bold = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Resaltar texto al copiar (yank)",
    callback = function()
        vim.hl.on_yank({
            higroup = "YankHighlight",
            timeout = 200,
        })
    end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     desc = "Formatear código al guardar",
--     callback = function()
--         require("conform").format({
--             lsp_fallback = true,
--             async = false,
--             timeout_ms = 1000,
--         })
--     end,
-- })
