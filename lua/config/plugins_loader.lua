local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local files = vim.fn.readdir(plugin_dir)

local priority_list = {
    "snacks",
    "tokyonight",
    "persistence",
    "mini",
    "noice" }

local priority_set = {}

for _, plugin in ipairs(priority_list) do
    require("plugins." .. plugin)
    priority_set[plugin] = true
end

vim.schedule(function()
    for _, file in ipairs(files) do
        local module = file:gsub("%.lua$", "")
        if file:match("%.lua$") and not priority_set[module] then
            require("plugins." .. module)
        end
    end
end)
