local mode_colors = {
    n = { name = "NORMAL", hl = "Normal", fg = "#1a1b26", bg = "#7aa2f7" },
    i = { name = "INSERT", hl = "Insert", fg = "#1a1b26", bg = "#9ece6a" },
    v = { name = "VISUAL", hl = "Visual", fg = "#1a1b26", bg = "#bb9af7" },
    V = { name = "V-LINE", hl = "Visual", fg = "#1a1b26", bg = "#bb9af7" },
    ["\22"] = { name = "V-BLOCK", hl = "Visual", fg = "#1a1b26", bg = "#bb9af7" },
    R = { name = "REPLACE", hl = "Replace", fg = "#1a1b26", bg = "#f7768e" },
    c = { name = "COMMAND", hl = "Command", fg = "#1a1b26", bg = "#e0af68" },
    t = { name = "TERMINAL", hl = "Terminal", fg = "#1a1b26", bg = "#4fd6be" },
}

local git_hl_prefix = {}
for _, data in pairs(mode_colors) do
    vim.api.nvim_set_hl(0, "StatuslineMode" .. data.hl, { fg = data.fg, bg = data.bg, bold = true })
    vim.api.nvim_set_hl(0, "StatuslineGit" .. data.hl, { fg = data.bg, bold = true })
    git_hl_prefix[data.hl] = "%#StatuslineGit" .. data.hl .. "# "
end

vim.api.nvim_set_hl(0, "StatuslineInactive", { fg = "#565f89", bg = "none" })
vim.api.nvim_set_hl(0, "SearchCount", { fg = "#ff9e64", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "MacroRecording", { fg = "#ff9e64", bg = "none", bold = true })

vim.api.nvim_set_hl(0, "StatuslineLspProgress", { fg = "#7aa2f7", bg = "none" })
vim.api.nvim_set_hl(0, "StatuslineDiagError", { fg = "#f7768e", bg = "none" })
vim.api.nvim_set_hl(0, "StatuslineDiagWarn", { fg = "#e0af68", bg = "none" })
vim.api.nvim_set_hl(0, "StatuslineDiagInfo", { fg = "#7aa2f7", bg = "none" })
vim.api.nvim_set_hl(0, "StatuslineDiagHint", { fg = "#1abc9c", bg = "none" })

local function update_cached_path(bufnr)
    local path = vim.api.nvim_buf_get_name(bufnr)
    if path == "" then
        vim.b[bufnr].cached_path = "%#Bold#[No Name]%*"
        return
    end

    local cwd = vim.uv.cwd() or ""
    local home = vim.env.HOME or ""
    if cwd ~= "" and path:find(cwd, 1, true) == 1 then
        path = path:sub(#cwd + 2)
    elseif home ~= "" and path:find(home, 1, true) == 1 then
        path = "~" .. path:sub(#home + 1)
    end

    local parts = {}
    for part in path:gmatch("[^/]+") do table.insert(parts, part) end
    local filename = table.remove(parts) or ""
    local dir = #parts > 2 and (parts[1] .. "/…/" .. parts[#parts] .. "/")
        or (#parts > 0 and (table.concat(parts, "/") .. "/") or "")

    vim.b[bufnr].cached_path = dir .. "%#Bold#" .. filename .. "%*"
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
    callback = function(args) update_cached_path(args.buf) end,
})

local function get_lsp_status()
    local progress = vim.lsp.status()
    if progress ~= "" then
        return "%#StatuslineLspProgress#" .. progress .. " %*"
    end
    return ""
end

local diag_severities = {
    { sev = vim.diagnostic.severity.ERROR, hl = "StatuslineDiagError", icon = " " },
    { sev = vim.diagnostic.severity.WARN, hl = "StatuslineDiagWarn", icon = " " },
    { sev = vim.diagnostic.severity.INFO, hl = "StatuslineDiagInfo", icon = " " },
    { sev = vim.diagnostic.severity.HINT, hl = "StatuslineDiagHint", icon = " " },
}

local function get_diagnostics()
    local counts = vim.diagnostic.count(0)
    local parts = {}

    for _, d in ipairs(diag_severities) do
        local n = counts[d.sev] or 0
        if n > 0 then
            table.insert(parts, string.format("%%#%s#%s%d%%*", d.hl, d.icon, n))
        end
    end

    return #parts > 0 and (table.concat(parts, " ") .. " ") or ""
end

vim.api.nvim_create_autocmd({ "LspProgress", "DiagnosticChanged", "LspAttach", "LspDetach" }, {
    callback = function()
        vim.schedule(function() vim.cmd("redrawstatus") end)
    end,
})

local function get_macro_recording()
    local reg = vim.fn.reg_recording()
    return reg ~= "" and ("%#MacroRecording# grabando @" .. reg .. " %*") or ""
end

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
    callback = function()
        vim.schedule(function() vim.cmd("redrawstatus") end)
    end,
})

local function get_search_count()
    if vim.v.hlsearch == 0 then return "" end
    local ok, count = pcall(vim.fn.searchcount, { recompute = 1, maxcount = 999 })
    if ok and count and count.total > 0 then
        local max = count.incomplete == 2 and ">" or ""
        return "%#SearchCount#[" .. count.current .. "/" .. max .. count.total .. "] %*"
    end
    return ""
end

function StatuslineRender()
    local ft = vim.bo.filetype
    if ft == "snacks_dashboard" or ft == "dashboard" or ft == "alpha" then
        return ""
    end

    if vim.g.statusline_winid ~= vim.api.nvim_get_current_win() then
        return "%#StatuslineInactive# %t%m%=%l:%c "
    end

    local m = vim.api.nvim_get_mode().mode
    local conf = mode_colors[m] or mode_colors[m:sub(1, 1)] or mode_colors.n
    local mode_str = string.format("%%#StatuslineMode%s# %s %%* ", conf.hl, conf.name)

    local head = vim.b.gitsigns_head
    local git_str = (head and head ~= "") and string.format("%s%s %%* ", git_hl_prefix[conf.hl], head) or ""

    return table.concat({
        mode_str,
        git_str,
        get_diagnostics(),
        vim.b.cached_path or "%#Bold#[No Name]%*",
        " %m%r ",
        "%=",
        get_lsp_status(),
        get_macro_recording(),
        get_search_count(),
        "%y ",
    })
end

vim.o.statusline = "%!v:lua.StatuslineRender()"

vim.api.nvim_create_autocmd("ModeChanged", {
    callback = function()
        vim.schedule(function() vim.cmd("redrawstatus") end)
    end,
})
