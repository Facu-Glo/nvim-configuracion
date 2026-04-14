require("config.options")
require("config.plugins_loader")
require("config.keymaps_basic")

vim.schedule(function()
    require("config.keymaps_plugins")
    require("config.usercommand")
    require("config.autocmds")
end)
