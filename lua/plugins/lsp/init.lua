vim.pack.add({
    { src = "https://github.com/Saghen/blink.cmp.git", version = "main" },
    { src = "https://github.com/mason-org/mason.nvim.git", version = "main" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim.git", version = "main" },
    { src = "https://github.com/neovim/nvim-lspconfig.git", version = "master" },
    { src = "https://github.com/stevearc/conform.nvim.git" },
    { src = "https://github.com/folke/trouble.nvim.git" },
})

require("plugins.lsp.blink")
require("plugins.lsp.mason")
require("plugins.lsp.lspconfig")
require("plugins.lsp.conform")
require("plugins.lsp.trouble")
