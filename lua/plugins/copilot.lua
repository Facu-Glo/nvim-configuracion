return {
    {
        "zbirenbaum/copilot.lua",
        optional = true,
        opts = function()
            require("copilot").setup {
                filetypes = {
                    markdown = true,
                    terraform = false,
                    sh = function()
                        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
                            return false
                        end
                        return true
                    end,
                },
            }
        end,
    },
    {
        "Exafunction/windsurf.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
            })
        end
    },
}
