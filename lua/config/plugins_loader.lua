local categories = {
    "plugins.ui",
    "plugins.completion",
    "plugins.lsp",
    "plugins.diagnostic",
    "plugins.syntax",
    "plugins.editing",
    "plugins.navigation",
    "plugins.git",
}

for _, category in ipairs(categories) do
    local ok, err = pcall(require, category)
    if not ok then
        vim.notify("Error cargando categoría: " .. category .. "\n" .. err, vim.log.levels.ERROR)
    end
end
