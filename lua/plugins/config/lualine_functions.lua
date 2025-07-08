-- lualine_functions.lua
local M = {}

-- Función para mostrar la ruta del archivo
M.pretty_path = function()
    local path = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd()
    local home = vim.env.HOME

    if path:find(cwd, 1, true) then
        path = path:sub(#cwd + 2)
    end

    path = path:gsub(home, "~")

    local parts = {}
    for part in path:gmatch("[^/]+") do
        table.insert(parts, part)
    end

    local filename = table.remove(parts)
    local final_path = ""

    if #parts > 2 then
        final_path = parts[1] .. "/…/" .. parts[#parts] .. "/"
    else
        final_path = table.concat(parts, "/") .. "/"
    end

    local status = ""
    if vim.bo.modified then
        status = " [+]"
    elseif vim.bo.readonly or not vim.bo.modifiable then
        status = " [-]"
    elseif vim.fn.expand("%") == "" then
        status = " [No Name]"
    end

    return final_path .. "%#LualineFilename#" .. filename .. status
end

-- Función para mostrar el estado de grabación de macros
M.get_macro_recording_status = function()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "%#MacroRecording#Recording @" .. recording_register .. "%*"
    end
end

-- Función para mostrar el modo de Neovim
M.custom_mode = function()
    local mode_map = {
        ['n']   = 'NORMAL',
        ['ce']  = 'NORMAL',
        ['nt']  = 'NORMAL',
        ['no']  = 'N-PENDING',
        ['niI'] = 'I-NORMAL',
        ['v']   = 'VISUAL',
        ['V']   = 'V-LINE',
        ['']   = 'V-BLOCK',
        ['s']   = 'SELECT',
        ['S']   = 'S-LINE',
        ['']   = 'S-BLOCK',
        ['i']   = 'INSERT',
        ['ic']  = 'INSERT',
        ['R']   = 'REPLACE',
        ['Rv']  = 'V-REPLACE',
        ['c']   = 'COMMAND',
        ['cv']  = 'EX',
        ['r']   = 'REPLACE',
        ['rm']  = 'MORE',
        ['r?']  = 'CONFIRM',
        ['!']   = 'SHELL',
        ['t']   = 'TERMINAL',
    }
    local mode_code = vim.api.nvim_get_mode().mode
    local mode_name = mode_map[mode_code] or mode_code
    return " " .. mode_name
end

return M
