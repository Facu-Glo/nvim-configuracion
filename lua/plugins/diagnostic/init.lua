
vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim.git" },
    { src = "https://github.com/folke/trouble.nvim.git" },
})

require("plugins.diagnostic.conform")
require("plugins.diagnostic.trouble")
