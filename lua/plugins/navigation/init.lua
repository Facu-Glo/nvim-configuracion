vim.pack.add({
    { src = "https://github.com/folke/flash.nvim.git" },
    { src = "https://github.com/A7Lavinraj/fyler.nvim.git", version = "main" },
})

require("plugins.navigation.flash")
require("plugins.navigation.fyler")
