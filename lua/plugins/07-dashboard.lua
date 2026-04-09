vim.pack.add({
    { src = "https://github.com/nvimdev/dashboard-nvim.git" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons.git" }
})

local v = vim.version()
local version_str = string.format("Version %d.%d.%d", v.major, v.minor, v.patch)

require("dashboard").setup({
    theme = 'hyper',
    config = {
        week_header = {
            enable = false,
            append = { version_str },
        },
        packages = { enable = true },
        shortcut = {
            {
                icon = ' ',
                desc = 'Quit Neovim',
                action = 'qa',
                key = 'q',
            },
            {
                icon = ' ',
                desc = 'Sesión',
                group = '@property',
                action = function()
                    local session_name = vim.fn.getcwd():gsub("/", "%%")
                    require("mini.sessions").read(session_name)
                end,
                key = 's'
            },
            {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Find Files',
                group = 'Label',
                action = 'Snacks.picker.files()',
                key = 'f',
            },
            {
                icon = '󰱼 ',
                desc = 'Find Text',
                group = 'DiagnosticHint',
                action = 'Snacks.picker.grep()',
                key = 'g'
            },
        },
        project = {
            enable = true,
            limit = 8,
            action = function(path)
                Snacks.picker.files({ cwd = path })
            end,
        },
        mru = {
            enable = true,
            limit = 6,
            cwd_only = false,
        },
        footer = {
            "",
            version_str,
            ""
        },
    }
})
