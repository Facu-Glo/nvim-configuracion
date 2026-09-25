vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim.git", version = "main" },
})

require("mason").setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed   = "✓",
            package_pending     = "➜",
            package_uninstalled = "✗",
        },
    },
})
