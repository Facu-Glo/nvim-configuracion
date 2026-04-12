vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim.git",    version = "main" },
    { src = "https://github.com/nvim-lualine/lualine.nvim.git" },
    { src = "https://github.com/folke/noice.nvim.git" },
    { src = "https://github.com/rcarriga/nvim-notify.git" },
    { src = "https://github.com/MunifTanjim/nui.nvim.git" },
    { src = "https://github.com/akinsho/bufferline.nvim.git",  version = "main" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/folke/snacks.nvim.git",        version = "main" },
    { src = "https://github.com/folke/which-key.nvim.git" },
})

require("plugins.ui.tokyonight")
require("plugins.ui.lualine")
require("plugins.ui.noice")
require("plugins.ui.bufferline")
require("plugins.ui.snacks")
require("plugins.ui.whichkeys")
