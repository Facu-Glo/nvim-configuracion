local create_command = vim.api.nvim_create_user_command

local function tab_pick()
    vim.cmd("tabnew")
    require("snacks.picker").files()
end

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

local function abrir_pdf(opts)
    local archivo = opts.args
    if not archivo:match("%.pdf$") then
        archivo = archivo .. ".pdf"
    end

    local ruta_completa = vim.fn.expand(archivo)

    if vim.fn.filereadable(ruta_completa) == 1 then
        vim.fn.jobstart({ "xdg-open", ruta_completa }, { detach = true })
        print("Abriendo: " .. archivo)
    else
        print("Error: El archivo '" .. archivo .. "' no existe.")
    end
end

create_command("TabPick", tab_pick, { desc = "Abrir archivo en nueva pestaña con snacks.picker.files" })
create_command("Format", format_code, { range = true, desc = "Formatear código con Conform" })
create_command("CopyAll", copy_all_buffers, { desc = "Copia contenido de buffers con su ruta usando bufdo" })
create_command('PDF', abrir_pdf, { nargs = 1, complete = "file" })
