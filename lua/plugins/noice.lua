return {
    {
        "folke/noice.nvim",
        dependencies = {
            "rcarriga/nvim-notify",
        },
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                views = {
                    cmdline_popup = {
                        position = {
                            row = 2,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = "auto",
                        },
                        border = {
                            style = "rounded",
                        },
                    },
                },
                cmdline = {
                    view = "cmdline",
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
                        enabled = true,
                    },
                },
                presets = {
                    lsp_doc_border = true,
                },

                documentation = {
                    view = "hover",
                    opts = {
                        lang = "txt",
                        replace = true,
                        render = "plain",
                        format = { "{message}" },
                        win_options = { concealcursor = "n", conceallevel = 3 },
                    },
                },
            })
        end,
    },
}
