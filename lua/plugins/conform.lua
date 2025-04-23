return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
            },
            format_on_save = {
                timeout_ms = 500,        -- tiempo máximo para formatear
                lsp_format = "fallback", -- si no hay formateador, usa el del LSP
            },
        })
    end
}
