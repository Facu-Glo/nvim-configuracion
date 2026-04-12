vim.pack.add({
    { src = "https://github.com/echasnovski/mini.nvim.git",         version = "main" },
    { src = "https://github.com/jake-stewart/multicursor.nvim.git", version = "1.0" },
})

require("plugins.editing.mini")
require("plugins.editing.multicursor")
