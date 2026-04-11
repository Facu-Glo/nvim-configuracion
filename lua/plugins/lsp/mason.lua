require("mason").setup({
    ui = {
        icons = {
            package_installed   = "✓",
            package_pending     = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "bashls",
        "jsonls",
        "html",
        "cssls",
        "elixirls",
        "clangd",
    },
    automatic_installation = true,
})

