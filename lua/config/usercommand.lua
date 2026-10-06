local create_command = vim.api.nvim_create_user_command

local function copy_all_buffers()
    local pieces = {}

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buflisted then
            local file_path = vim.api.nvim_buf_get_name(buf)
            local rel_name = file_path ~= "" and vim.fn.fnamemodify(file_path, ":.") or "[Sin Nombre]"
            local content = nil

            if vim.api.nvim_buf_is_loaded(buf) then
                local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                content = table.concat(lines, "\n")
            elseif file_path ~= "" then
                local fd = vim.uv.fs_open(file_path, "r", 438)
                if fd then
                    local stat = vim.uv.fs_fstat(fd)
                    if stat then
                        content = stat.size > 0 and (vim.uv.fs_read(fd, stat.size, 0) or "") or ""
                    end
                    vim.uv.fs_close(fd)
                end
            end

            if content ~= nil then
                table.insert(pieces, string.format("--- ARCHIVO: %s ---\n%s", rel_name, content))
            end
        end
    end

    if #pieces == 0 then
        vim.notify("No hay buffers para copiar.", vim.log.levels.WARN)
        return
    end

    vim.fn.setreg("+", table.concat(pieces, "\n\n") .. "\n")
    vim.notify(string.format("¡Copiados %d archivos al portapapeles!", #pieces))
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
