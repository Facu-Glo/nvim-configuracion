vim.loader.enable()

require("config.options")
require("config.plugins_loader")
require("config.keymaps")
require("config.statusline")

vim.schedule(function()
    require("config.usercommand")
    require("config.autocmds")
end)
