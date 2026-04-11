vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig.git", version = "master" },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

local diagnostic_icons = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = "●",
        source = "if_many",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
            [vim.diagnostic.severity.WARN] = diagnostic_icons.Warn,
            [vim.diagnostic.severity.INFO] = diagnostic_icons.Info,
            [vim.diagnostic.severity.HINT] = diagnostic_icons.Hint,
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local map = vim.keymap.set
        local opts = { buffer = ev.buf, silent = true }

        local function lsp_map(lhs, rhs, desc)
            map("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
        end

        -- lsp_map("gd", vim.lsp.buf.definition, "Ir a definición")
        -- lsp_map("gD", vim.lsp.buf.declaration, "Ir a declaración")
        lsp_map("<leader>cd", vim.lsp.buf.definition, "Ir a definición")
        lsp_map("<leader>cD", vim.lsp.buf.declaration, "Ir a declaración")
        lsp_map("gr", function() Snacks.picker.lsp_references() end, "Referencias (Snacks)")
        lsp_map("gi", vim.lsp.buf.implementation, "Ir a implementación")
        lsp_map("K", vim.lsp.buf.hover, "Hover")
        lsp_map("<leader>cr", vim.lsp.buf.rename, "Renombrar")
        lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        lsp_map("<leader>ce", vim.diagnostic.open_float, "Diagnóstico flotante")
        lsp_map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Diagnóstico anterior")
        lsp_map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Diagnóstico siguiente")
    end,
})

local servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim", "Snacks" } },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        vim.fn.stdpath("config"),
                    },
                },
                telemetry = { enable = false },
            },
        },
    },
    ts_ls = {},
    pyright = {},
    bashls = { filetypes = { "sh", "bash", "zsh" }, },
    jsonls = {},
    html = {},
    cssls = {},
    clangd = {},
    elixirls = {
    },
}

for server, config in pairs(servers) do
    config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end
