local mode_colors = {
    normal   = { fg = "#1a1b26", bg = "#7aa2f7" },
    insert   = { fg = "#1a1b26", bg = "#7dcfff" },
    visual   = { fg = "#1a1b26", bg = "#bb9af7" },
    replace  = { fg = "#1a1b26", bg = "#f7768e" },
    command  = { fg = "#1a1b26", bg = "#e0af68" },
    terminal = { fg = "#1a1b26", bg = "#9ece6a" },
    select   = { fg = "#1a1b26", bg = "#ff9e64" },
}

local hl_mode_groups = {}
local hl_git_groups = {}

for name, colors in pairs(mode_colors) do
    local capitalized = name:gsub("^%l", string.upper)

    local mode_group = "StatuslineMode" .. capitalized
    vim.api.nvim_set_hl(0, mode_group, {
        fg = colors.fg,
        bg = colors.bg,
        bold = true,
    })
    hl_mode_groups[name] = mode_group

    local git_group = "StatuslineGit" .. capitalized
    vim.api.nvim_set_hl(0, git_group, {
        fg = colors.bg,
        bold = true,
    })
    hl_git_groups[name] = git_group
end

local VBLOCK = vim.fn.nr2char(22)
local SBLOCK = vim.fn.nr2char(19)

local mode_map = {
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

local function get_current_mode_info()
    local code = vim.api.nvim_get_mode().mode
    return mode_map[code] or { code:upper(), "normal" }
end

local function current_mode(entry)
    local label = entry[1]
    local color = entry[2]
    return "%#" .. hl_mode_groups[color] .. "# " .. label .. " %*"
end

local function pretty_path()
    local raw_path = vim.fn.expand("%:p")
    if raw_path == "" then
        return "%#Bold#[No Name]%*"
    end

    local cwd = vim.fn.getcwd()
    local home = vim.env.HOME or ""

    local path = raw_path
    if path:find(cwd, 1, true) then
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

    local status = ""
    if vim.bo.modified then
        status = " [+]"
    elseif vim.bo.readonly or not vim.bo.modifiable then
        status = " [-]"
    end

    return dir_path .. "%#Bold#" .. filename .. "%*" .. status
end

local function git_branch(entry)
    local head = vim.b.gitsigns_head
    if head and head ~= "" then
        local color = entry[2]
        return " %#" .. hl_git_groups[color] .. "# " .. head .. " %* "
    end
    return " "
end

function StatuslineRender()
    local mode_entry = get_current_mode_info()
    return table.concat({
        current_mode(mode_entry),
        git_branch(mode_entry),
        pretty_path(),
        "%=",
        "%y ",
        "%l:%c ",
    })
end

vim.o.statusline = "%!v:lua.StatuslineRender()"

vim.api.nvim_create_autocmd("ModeChanged", {
    callback = function()
        vim.cmd("redrawstatus")
    end,
})
