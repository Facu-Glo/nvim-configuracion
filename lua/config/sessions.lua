local M = {}

function M.get_session_name()
    local name = vim.fn.getcwd():gsub("[\\/:]", "%%")
    local branch = vim.fn.systemlist("git branch --show-current 2>/dev/null")[1]
    if branch and branch ~= "" then
        name = name .. "%%" .. branch:gsub("[\\/:]", "%%")
    end
    return name .. ".vim"
end

function M.get_dir_session_name()
    return vim.fn.getcwd():gsub("[\\/:]", "%%") .. ".vim"
end

function M.restore()
    local sessions = require("mini.sessions")
    local name = M.get_session_name()
    local dir_name = M.get_dir_session_name()

    if sessions.detected[name] then
        sessions.read(name)
        vim.notify("Sesión restaurada (" .. vim.fs.basename(vim.fn.getcwd()) .. ")")
        return true
    end

    if sessions.detected[dir_name] then
        sessions.read(dir_name)
        vim.notify("Sesión restaurada [fallback] (" .. vim.fs.basename(vim.fn.getcwd()) .. ")")
        return true
    end

    local ok = pcall(sessions.read, name)
    if not ok then
        ok = pcall(sessions.read, dir_name)
    end

    if ok then
        vim.notify("Sesión restaurada (" .. vim.fs.basename(vim.fn.getcwd()) .. ")")
        return true
    else
        vim.notify("No hay sesión guardada para este directorio", vim.log.levels.WARN)
        return false
    end
end

function M.setup()
    vim.api.nvim_create_autocmd("ExitPre", {
        group = vim.api.nvim_create_augroup("MiniSessionsAutoSave", { clear = true }),
        callback = function()
            if vim.bo.buftype ~= "" then
                return
            end

            local git_filetypes = {
                gitcommit = true,
                gitrebase = true,
                git = true,
                gitconfig = true,
            }
            if git_filetypes[vim.bo.filetype] then
                return
            end

            local valid_bufs = vim.tbl_filter(function(b)
                return vim.bo[b].buflisted and vim.bo[b].buftype == "" and not git_filetypes[vim.bo[b].filetype]
            end, vim.api.nvim_list_bufs())

            if #valid_bufs > 0 then
                require("mini.sessions").write(M.get_session_name(), { force = true })
            end
        end,
    })
end

return M
