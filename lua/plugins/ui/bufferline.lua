require("bufferline").setup({
    options = {
        close_command = "bdelete! %d",
        right_mouse_command = false,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        indicator = {
            style = "underline",
        },
        diagnostics_indicator = function(_, _, diag)
            local icons = {
                Error = " ",
                Warn = " ",
                Info = " ",
                Hint = " ",
            }
            local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                .. (diag.warning and icons.Warn .. diag.warning or "")
            return vim.trim(ret)
        end,
        offsets = {
            {
                filetype = "neo-tree",
                text = "Neo-tree",
                highlight = "Directory",
                text_align = "left",
            },
            {
                filetype = "snacks_layout_box",
            },
            {
                filetype = "fyler",
                highlight = "Directory",
                text_align = "left",
            },
        },
        color_icons = true,
        show_buffer_close_icons = true,
        pick = {
            alphabet = "123456789",
        },
    },
})

