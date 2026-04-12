vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "main" },
})

require("plugins.syntax.treesitter")
