vim.pack.add({
    { src = "https://github.com/folke/persistence.nvim.git" },
})

require("persistence").setup({
    dir = vim.fn.stdpath("state") .. "/sessions/",
    need = 1,
    branch = true,
})
