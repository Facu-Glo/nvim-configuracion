local M = {}

local defaults = {
    mode_style = "solid",
    mode_separator = "",
    git_separator = "",
    layout = {
        left  = { "mode", "git", "path" },
        right = { "lsp", "macro", "search", "diag", "filetype" },
    },
}

M.options = {}

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

local function setup_highlights()
    for _, data in pairs(mode_colors) do
        vim.api.nvim_set_hl(0, "StatuslineModeSolid" .. data.hl, { fg = data.fg, bg = data.bg, bold = true })
        vim.api.nvim_set_hl(0, "StatuslineModeSep" .. data.hl, { fg = data.bg, bg = "none" })
        vim.api.nvim_set_hl(0, "StatuslineModeText" .. data.hl, { fg = data.bg, bg = "none", bold = true })
        vim.api.nvim_set_hl(0, "StatuslineGit" .. data.hl, { fg = data.bg, bg = "none", bold = true })
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
end

local mode_templates = {
    solid = function(conf, sep)
        if sep ~= "" then
            return string.format("%%#StatuslineModeSolid%s# %s %%*%%#StatuslineModeSep%s#%s%%* ", conf.hl, conf.name,
                conf.hl, sep)
        end
        return string.format("%%#StatuslineModeSolid%s# %s %%* ", conf.hl, conf.name)
    end,

    bar = function(conf, sep)
        local s = sep ~= "" and (sep .. " ") or ""
        return string.format("%%#StatuslineModeText%s#█ %s %s%%*", conf.hl, conf.name, s)
    end,

    text = function(conf, sep)
        local s = sep ~= "" and (sep .. " ") or ""
        return string.format("%%#StatuslineModeText%s#%s %s%%*", conf.hl, conf.name, s)
    end,
}

local render_mode_fn = mode_templates.solid

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
    for part in path:gmatch("[^/]+") do parts[#parts + 1] = part end
    local filename = table.remove(parts) or ""
    local dir = #parts > 2 and (parts[1] .. "/…/" .. parts[#parts] .. "/")
        or (#parts > 0 and (table.concat(parts, "/") .. "/") or "")

    vim.b[bufnr].cached_path = dir .. "%#Bold#" .. filename .. "%*"
end

local diag_severities = {
    { sev = vim.diagnostic.severity.ERROR, hl = "StatuslineDiagError", icon = " " },
    { sev = vim.diagnostic.severity.WARN, hl = "StatuslineDiagWarn", icon = " " },
    { sev = vim.diagnostic.severity.INFO, hl = "StatuslineDiagInfo", icon = " " },
    { sev = vim.diagnostic.severity.HINT, hl = "StatuslineDiagHint", icon = " " },
}

local function update_cached_diagnostics(bufnr)
    local counts = vim.diagnostic.count(bufnr)
    local acc = {}
    for i = 1, #diag_severities do
        local d = diag_severities[i]
        local n = counts[d.sev] or 0
        if n > 0 then
            acc[#acc + 1] = string.format("%%#%s#%s%d%%*", d.hl, d.icon, n)
        end
    end
    vim.b[bufnr].cached_diag = #acc > 0 and (table.concat(acc, " ") .. " ") or ""
end

-- Implementación idéntica a mini.statusline
local function section_search()
    if vim.v.hlsearch == 0 then return "" end
    local last_search = vim.fn.getreg("/")
    if not last_search or last_search == "" then return "" end

    local ok, res = pcall(vim.fn.searchcount, { options = "fswp", timeout = 100, maxcount = 999, recompute = 1 })
    if not ok or not res or not res.total or res.total == 0 then return "" end

    if res.incomplete == 1 then
        return "%#SearchCount#[?/??] %*"
    end

    local total = res.incomplete == 2 and (">" .. res.total) or res.total
    return string.format("%%#SearchCount#[%s/%s] %%*", res.current, total)
end

local components = {
    mode = function(ctx)
        return render_mode_fn(ctx.conf, M.options.mode_separator)
    end,
    git = function(ctx)
        local head = vim.b[ctx.bufnr].gitsigns_head
        if head and head ~= "" then
            return string.format("%s%s %s%%* ", git_hl_prefix[ctx.conf.hl], head, M.options.git_separator or "")
        end
        return ""
    end,
    path = function(ctx)
        return (vim.b[ctx.bufnr].cached_path or "%#Bold#[No Name]%*") .. " %m%r "
    end,
    lsp = function()
        local progress = vim.lsp.status()
        return progress ~= "" and ("%#StatuslineLspProgress#" .. progress .. " %*") or ""
    end,
    macro = function()
        local reg = vim.fn.reg_recording()
        return reg ~= "" and ("%#MacroRecording# grabando @" .. reg .. " %*") or ""
    end,
    search = section_search,
    diag = function(ctx)
        return vim.b[ctx.bufnr].cached_diag or ""
    end,
    filetype = function() return "%y " end,
    location = function() return "%l:%c " end,
}

local function render_section(keys, ctx)
    local out = {}
    for i = 1, #keys do
        local fn = components[keys[i]]
        if fn then
            local val = fn(ctx)
            if val and val ~= "" then
                out[#out + 1] = val
            end
        end
    end
    return table.concat(out)
end

function _G.__CustomStatuslineRender()
    local ft = vim.bo.filetype
    if ft == "snacks_dashboard" or ft == "dashboard" or ft == "alpha" or ft == "fyler_finder" then
        return ""
    end

    if vim.g.statusline_winid ~= vim.api.nvim_get_current_win() then
        return "%#StatuslineInactive# %t%m%=%l:%c "
    end

    local m = vim.api.nvim_get_mode().mode
    local conf = mode_colors[m] or mode_colors[m:sub(1, 1)] or mode_colors.n

    local ctx = {
        bufnr = vim.api.nvim_get_current_buf(),
        conf = conf,
    }

    local left_str = render_section(M.options.layout.left, ctx)
    local right_str = render_section(M.options.layout.right, ctx)

    return left_str .. "%=" .. right_str
end

function M.setup(opts)
    M.options = vim.tbl_deep_extend("force", defaults, opts or {})
    render_mode_fn = mode_templates[M.options.mode_style] or mode_templates.solid

    setup_highlights()

    local group = vim.api.nvim_create_augroup("CustomStatusline", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
        group = group,
        callback = function(args)
            update_cached_path(args.buf)
            update_cached_diagnostics(args.buf)
        end,
    })

    vim.api.nvim_create_autocmd("DiagnosticChanged", {
        group = group,
        callback = function(args)
            update_cached_diagnostics(args.buf)
            vim.cmd("redrawstatus")
        end,
    })

    vim.api.nvim_create_autocmd({ "LspProgress", "RecordingEnter", "RecordingLeave" }, {
        group = group,
        callback = function()
            vim.cmd("redrawstatus")
        end,
    })

    vim.o.statusline = "%!v:lua.__CustomStatuslineRender()"
end

M.setup({
    mode_style     = "bar",
    mode_separator = "",
    git_separator  = "",

    layout         = {
        left = {
            "mode",
            "git",
            "path"
        },
        right = {
            "diag",
            "search",
            "macro",
            "lsp",
            "filetype"
        },
    },
})

return M
