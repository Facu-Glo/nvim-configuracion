vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim.git", version = "main" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim.git", version = "main" },
    { src = "https://github.com/neovim/nvim-lspconfig.git", version = "master" },
})

require("plugins.lsp.mason")
require("plugins.lsp.lspconfig")
