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
    "whichkeys",
    "fyler",
}

for _, plugin in ipairs(plugins) do
    require("plugins." .. plugin)
end
