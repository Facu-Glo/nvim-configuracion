vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim.git", version = "main" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim.git", version = "main" },
})
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
        "ruff",
        "latexindent",
    },
    automatic_installation = true,
})

