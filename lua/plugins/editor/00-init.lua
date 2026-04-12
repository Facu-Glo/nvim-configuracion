vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "main" },
    { src = "https://github.com/echasnovski/mini.nvim.git", version = "main" },
    { src = "https://github.com/folke/flash.nvim.git" },
    { src = "https://github.com/A7Lavinraj/fyler.nvim.git", version = "main" },
    { src = "https://github.com/jake-stewart/multicursor.nvim.git", version = "1.0" },
})

require("plugins.editor.treesitter")
require("plugins.editor.mini")
require("plugins.editor.flash")
require("plugins.editor.fyler")
require("plugins.editor.multicursor")
