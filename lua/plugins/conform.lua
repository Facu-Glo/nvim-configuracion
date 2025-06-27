return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                rust = { "rustfmt", lsp_format = "fallback" },
                javascript = { "prettier", stop_after_first = true },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                c = { "clang_format" },
                cpp = { "clang_format" },
            },
            format_on_save = {
                timeout_ms = 500,        -- tiempo máximo para formatear
                lsp_format = "fallback", -- si no hay formateador, usa el del LSP
            },
            formatters = {
                prettier = {
                    prepend_args = { "--tab-width", "2", "--no-semi", "--single-quote" },
                },
                clang_format = {
                    command = "clang-format",
                    args = {
                        "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}"
                    },
                },
            },
        })
    end
}
