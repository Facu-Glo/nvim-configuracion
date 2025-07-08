return function(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- Navegación
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "Ir a definición" }))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "Mostrar Documentación" }))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
        vim.tbl_extend("force", bufopts, { desc = "Ir a implementación" }))
end
