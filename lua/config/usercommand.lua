vim.api.nvim_create_user_command("TabPick", function()
    vim.cmd("tabnew")
    require("snacks.picker").files()
end, { desc = "Abrir archivo en nueva pestaña con snacks.picker.files" })

vim.api.nvim_create_user_command("CopiarTodo", function()
    vim.fn.setreg('+', '')

    vim.cmd([[
        silent bufdo if &buflisted | let @+ .= "--- ARCHIVO: " . expand('%:.') . " ---\n" . getline(1, '$')->join("\n") . "\n\n" | endif
    ]])

    print("¡Todos los buffers listados han sido copiados!")
end, { desc = "Copia contenido de buffers con su ruta usando bufdo" })
