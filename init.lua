vim.loader.enable()

require("config.options")
require("config.plugins_loader")
require("config.keymaps")

vim.schedule(function()
    require("config.usercommand")
    require("config.autocmds")
end)
