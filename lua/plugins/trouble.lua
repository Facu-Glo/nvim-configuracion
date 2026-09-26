vim.pack.add({
    { src = "https://github.com/folke/trouble.nvim.git" },
})

require("trouble").setup({
    modes = {
        lsp = {
            focus = true,
        },
        diagnostics = {
            focus = true,
            win = {
                position = "bottom",
                size = 0.3,
            },
        },
        symbols = {
            desc = "document symbols",
            mode = "lsp_document_symbols",
            focus = true,
            win = {
                position = "bottom",
                size = 0.3,
            },
            filter = {
                any = {
                    ft = { "help", "markdown" },
                    kind = {
                        "Class",
                        "Constructor",
                        "Enum",
                        -- "Field",
                        "Function",
                        "Interface",
                        "Method",
                        "Module",
                        "Namespace",
                        "Package",
                        "Property",
                        "Struct",
                        "Trait",
                    },
                },
            },
        },
    },
})


vim.keymap.set("n",
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    { desc = "Diagnostics (Trouble)" }
)

vim.keymap.set("n",
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { desc = "Buffer Diagnostics (Trouble)" }
)

vim.keymap.set("n",
    "<leader>cl",
    "<cmd>Trouble lsp toggle <cr>",
    { desc = "LSP Definitions / references (Trouble)" }
)

vim.keymap.set("n",
    "<leader>cs",
    "<cmd>Trouble symbols toggle<cr>",
    { desc = "Symbols (Trouble)" }
)

vim.keymap.set("n",
    "<leader>xL",
    "<cmd>Trouble loclist toggle<cr>",
    { desc = "Location List (Trouble)" }
)

vim.keymap.set("n",
    "<leader>xQ",
    "<cmd>Trouble qflist toggle<cr>",
    { desc = "Quickfix List (Trouble)" }
)
