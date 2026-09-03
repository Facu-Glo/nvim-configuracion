local mode_colors = {
    normal   = { fg = "#1a1b26", bg = "#7aa2f7" },
    insert   = { fg = "#1a1b26", bg = "#9ece6a" },
    visual   = { fg = "#1a1b26", bg = "#bb9af7" },
    replace  = { fg = "#1a1b26", bg = "#f7768e" },
    command  = { fg = "#1a1b26", bg = "#e0af68" },
    terminal = { fg = "#1a1b26", bg = "#4fd6be" },
    select   = { fg = "#1a1b26", bg = "#ff9e64" },
}

local mode_strings = {}
local git_hl_prefix = {}

for name, colors in pairs(mode_colors) do
    local capitalized = name:gsub("^%l", string.upper)
    local m_group = "StatuslineMode" .. capitalized
    local g_group = "StatuslineGit" .. capitalized

    vim.api.nvim_set_hl(0, m_group, { fg = colors.fg, bg = colors.bg, bold = true })
    vim.api.nvim_set_hl(0, g_group, { fg = colors.bg, bold = true })

    git_hl_prefix[name] = "%#" .. g_group .. "# "
end

vim.api.nvim_set_hl(0, "MacroRecording", { fg = "#ff9e64", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "SearchCount", { fg = "#ff9e64", bg = "none", bold = true })

local VBLOCK = "\22"
local SBLOCK = "\19"

local raw_modes = {
    ["n"]    = { "NORMAL", "normal" },
    ["ce"]   = { "NORMAL", "normal" },
    ["nt"]   = { "NORMAL", "normal" },
    ["no"]   = { "N-PENDING", "normal" },
    ["niI"]  = { "I-NORMAL", "insert" },
    ["v"]    = { "VISUAL", "visual" },
    ["V"]    = { "V-LINE", "visual" },
    [VBLOCK] = { "V-BLOCK", "visual" },
    ["s"]    = { "SELECT", "select" },
    ["S"]    = { "S-LINE", "select" },
    [SBLOCK] = { "S-BLOCK", "select" },
    ["i"]    = { "INSERT", "insert" },
    ["ic"]   = { "INSERT", "insert" },
    ["R"]    = { "REPLACE", "replace" },
    ["Rv"]   = { "V-REPLACE", "replace" },
    ["c"]    = { "COMMAND", "command" },
    ["cv"]   = { "EX", "command" },
    ["r"]    = { "REPLACE", "replace" },
    ["rm"]   = { "MORE", "replace" },
    ["r?"]   = { "CONFIRM", "command" },
    ["!"]    = { "SHELL", "terminal" },
    ["t"]    = { "TERMINAL", "terminal" },
}

for code, data in pairs(raw_modes) do
    local label, color = data[1], data[2]
    local capitalized = color:gsub("^%l", string.upper)
    mode_strings[code] = "%#StatuslineMode" .. capitalized .. "# " .. label .. " %*"
end

local default_mode_str = "%#StatuslineModeNormal# NORMAL %*"
local default_git_pfx  = git_hl_prefix["normal"]

local function update_cached_path(bufnr)
    local raw_path = vim.api.nvim_buf_get_name(bufnr)
    if raw_path == "" then
        vim.b[bufnr].cached_pretty_path = "%#Bold#[No Name]%*"
        return
    end

    local cwd = vim.uv.cwd() or ""
    local home = vim.env.HOME or ""

    local path = raw_path
    if cwd ~= "" and path:find(cwd, 1, true) then
        path = path:sub(#cwd + 2)
    elseif home ~= "" and path:find(home, 1, true) then
        path = "~" .. path:sub(#home + 1)
    end

    local parts = {}
    for part in path:gmatch("[^/]+") do
        table.insert(parts, part)
    end

    local filename = table.remove(parts) or ""
    local dir_path = ""

    if #parts > 2 then
        dir_path = parts[1] .. "/…/" .. parts[#parts] .. "/"
    elseif #parts > 0 then
        dir_path = table.concat(parts, "/") .. "/"
    end

    vim.b[bufnr].cached_pretty_path = dir_path .. "%#Bold#" .. filename .. "%*"
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
    callback = function(args)
        update_cached_path(args.buf)
    end,
})

local function pretty_path()
    local path_str = vim.b.cached_pretty_path or "%#Bold#[No Name]%*"
    local status = ""
    if vim.bo.modified then
        status = " [+]"
    elseif vim.bo.readonly or not vim.bo.modifiable then
        status = " [-]"
    end
    return path_str .. status
end

local function get_macro_recording()
    local reg = vim.fn.reg_recording()
    if reg ~= "" then
        return "%#MacroRecording# grabando @" .. reg .. " %*"
    end
    return ""
end

local function get_search_count()
    if vim.v.hlsearch == 0 then
        return ""
    end
    local ok, count = pcall(vim.fn.searchcount, { recompute = 0, maxcount = 999 })
    if ok and count and count.total > 0 then
        local max = count.incomplete == 2 and ">" or ""
        return "%#SearchCount#[" .. count.current .. "/" .. max .. count.total .. "] %*"
    end
    return ""
end

vim.api.nvim_set_hl(0, "StatuslineInactive", { fg = "#565f89", bg = "none" })

local function statusline_inactive()
    return "%#StatuslineInactive# %t%m%=%l:%c "
end

function StatuslineRender()
    if vim.g.statusline_winid ~= vim.api.nvim_get_current_win() then
        return statusline_inactive()
    end

    local code = vim.api.nvim_get_mode().mode
    local mode_str = mode_strings[code] or default_mode_str

    local head = vim.b.gitsigns_head
    local git_str = " "
    if head and head ~= "" then
        local color = raw_modes[code] and raw_modes[code][2]
        local pfx = git_hl_prefix[color] or default_git_pfx
        git_str = " " .. pfx .. head .. " %* "
    end

    return table.concat({
        mode_str,
        git_str,
        pretty_path(),
        "%=",
        get_macro_recording(),
        get_search_count(),
        "%y ",
    })
end

vim.o.statusline = "%!v:lua.StatuslineRender()"

vim.api.nvim_create_autocmd({ "ModeChanged", "WinEnter", "WinLeave", "RecordingEnter", "RecordingLeave" }, {
    callback = function()
        vim.cmd("redrawstatus")
    end,
})
