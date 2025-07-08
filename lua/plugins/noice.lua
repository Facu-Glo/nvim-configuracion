return {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
        require("noice").setup({
            -- views = {
            --     cmdline_popup = {
            --         position = {
            --             row = 2,
            --             col = "50%",
            --         },
            --         size = {
            --             width = 60,
            --             height = "auto",
            --         },
            --         border = {
            --             style = "rounded",
            --         },
            --     },
            -- },
            cmdline = {
                view = "cmdline_popup",
                format = {
                    search_down = {
                        view = "cmdline",
                    },
                    search_up = {
                        view = "cmdline",
                    },
                },
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
                hover = {
                    enabled = true, -- Activa el hover de noice
                },
            },
            presets = {
                lsp_doc_border = true,
            },
        })
    end,
    dependencies = {
        "rcarriga/nvim-notify",
    },
}
