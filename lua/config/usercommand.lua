local create_command = vim.api.nvim_create_user_command

create_command("TabPick", function()
    vim.cmd("tabnew")
    require("snacks.picker").files()
end, { desc = "Abrir archivo en nueva pestaña con snacks.picker.files" })

create_command("CopiarTodo", function()
    vim.fn.setreg('+', '')

    vim.cmd([[
        silent bufdo if &buflisted | let @+ .= "--- ARCHIVO: " . expand('%:.') . " ---\n" . getline(1, '$')->join("\n") . "\n\n" | endif
    ]])

    print("¡Todos los buffers listados han sido copiados!")
end, { desc = "Copia contenido de buffers con su ruta usando bufdo" })

create_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format({
        lsp_fallback = true,
        timeout_ms = 500,
        range = range
    })
end, { range = true, desc = "Formatear código con Conform" })
