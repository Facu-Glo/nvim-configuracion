return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            local ts = require("nvim-treesitter")

            ts.setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            ts.install({
                "bash",
                "html",
                "javascript",
                "json", "java", "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query", "regex",
                "tsx",
                "typescript",
                "vim",
                "yaml",
                "nasm",
                "hyprlang",

                "xml",
                "rasi",
                "elixir",
                "heex",
                "eex"
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "bash", "html", "javascript", "json", "java", "lua", "python",
                    "elixir", "heex", "eex", "typescript", "tsx", "yaml", "xml"
                },
                callback = function()
                    vim.treesitter.start()

                    vim.wo.foldmethod = 'expr'
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
