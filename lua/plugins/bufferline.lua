vim.pack.add({
    { src = "https://github.com/akinsho/bufferline.nvim.git",  version = "main" },
    -- { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

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

------------------------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
vim.keymap.set("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
vim.keymap.set("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })
vim.keymap.set("n", "gb", "<CMD>BufferLinePick<CR>", { desc = "Pick Buffer" })
vim.keymap.set("n", "gD", "<CMD>BufferLinePickClose<CR>", { desc = "Pick Buffer Close" })
