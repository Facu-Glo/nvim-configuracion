local plugins = {
    "snacks",
    "tokyonight",
    "mini",
    "treesitter",
    "dap",
    "mason",
    "conform",
    "blink",
    "lspconfig",
    "trouble",
    "gitsigns",
    "codediff",
    "fyler",
}

for _, plugin in ipairs(plugins) do
    require("plugins." .. plugin)
end
