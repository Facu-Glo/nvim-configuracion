local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local files = vim.fn.readdir(plugin_dir)

for _, file in ipairs(files) do
    if file:match("%.lua$") then
        local module_name = "plugins." .. file:gsub("%.lua$", "")
        require(module_name)
    end
end
