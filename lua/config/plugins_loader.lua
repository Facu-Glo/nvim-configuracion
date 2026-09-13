local plugins = {
    "snacks",
    "tokyonight",
    "persistence",
    "mini",
    "treesitter",
    "dap",
    "mason",
    "conform",
    "blink",
    "lspconfig",
    "bufferline",
    "trouble",
    "gitsigns",
    "codediff",
    "live_server",
    "multicursor",
    "whichkeys",
    "fyler",
    "flash",
}

local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
for _, file in ipairs(vim.fn.readdir(plugin_dir)) do
    local module = file:gsub("%.lua$", "")
    if file:match("%.lua$") and not vim.iter(plugins):any(function(p) return p == module end) then
        vim.notify("Plugin sin registrar en plugins_loader: " .. module, vim.log.levels.WARN)
    end
end

for _, plugin in ipairs(plugins) do
    require("plugins." .. plugin)
end
