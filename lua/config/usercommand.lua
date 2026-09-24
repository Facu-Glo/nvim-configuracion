local create_command = vim.api.nvim_create_user_command

local function copy_all_buffers()
    vim.fn.setreg('+', '')

    vim.cmd([[
        silent bufdo if &buflisted | let @+ .= "--- ARCHIVO: " . expand('%:.') . " ---\n" . getline(1, '$')->join("\n") . "\n\n" | endif
    ]])

    print("¡Todos los buffers listados han sido copiados!")
end

local function format_code(args)
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
end

create_command("Format", format_code, { range = true, desc = "Formatear código con Conform" })
create_command("CopyAll", copy_all_buffers, { desc = "Copia contenido de buffers con su ruta usando bufdo" })
