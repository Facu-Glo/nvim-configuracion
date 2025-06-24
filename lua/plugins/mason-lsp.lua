return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
            local mr = require("mason-registry")
            local ensure_installed = {
                "lua-language-server",
                "rust-analyzer",
                "pyright",
                "asm-lsp",
                "bash-language-server",
                "clangd",
                "gopls",
                "jdtls",
                "hyprls",
                "css-lsp",
                "marksman",
                "ruff",
                "ts_ls",    --lsp de typescriptreact
                "prettier", -- formateador typescriptreact
            }

            for _, name in ipairs(ensure_installed) do
                local ok, pkg = pcall(mr.get_package, name)
                if ok and not pkg:is_installed() then
                    pkg:install()
                end
            end
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            -- "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
            -- "SmiteshP/nvim-navic",
        },
        config = function()
            -- Configuración de nvim-lspconfig
            local lspconfig = require("lspconfig")
            -- local navic = require("nvim-navic")

            -- Habilitar capacidades de autocompletado
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            -- Función común para cuando un servidor LSP se adjunta
            local on_attach = function(_, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }

                -- Configuración de atajos de teclado comunes
                vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                    vim.tbl_extend("force", bufopts, { desc = "Ir a definición" }))
                vim.keymap.set("n", "K", vim.lsp.buf.hover,
                    vim.tbl_extend("force", bufopts, { desc = "Mostrar Documentación" }))
                vim.keymap.set("n", "gr", vim.lsp.buf.references,
                    vim.tbl_extend("force", bufopts, { desc = "Buscar referencias" }))
                -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
                -- if client.server_capabilities.documentSymbolProvider then
                --     navic.attach(client, bufnr)
                -- end
            end

            -- Configuración para el servidor de Lua
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            -- Configuración para el servidor de Rust
            lspconfig.rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Configuración para el servidor de Python (Pyright)
            lspconfig.pyright.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            autoImportCompletions = true,
                            diagnosticMode = "openFilesOnly",
                        },
                    },
                },
            })

            lspconfig.ruff.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Configuración para el servidor de ASM
            lspconfig.asm_lsp.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "nasm", "asm", "s", "S" },
            })

            -- Configuración para el servidor de Bash
            lspconfig.bashls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Configuración para el servidor de C/C++ (Clangd)
            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Configuración para el servidor de Go
            lspconfig.gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Configuración para el servidor de Java (JDTLS)
            lspconfig.jdtls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lspconfig.hyprls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "hyprlang", "hypr", "conf" },
            })

            -- Configuración para Lemminx (XML)
            lspconfig.lemminx.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Configuración para Biome (JSON)
            -- lspconfig.biome.setup({
            --     cmd = { "biome", "lsp-proxy" },
            --     filetypes = { "json", "jsonc" },
            --     root_dir = require("lspconfig.util").root_pattern(".git", "package.json", "biome.json", "biome.jsonc"),
            -- })

            -- Configuración para CSS
            lspconfig.cssls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lspconfig.marksman.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = function()
                    return vim.fn.getcwd()
                end,
            })

            lspconfig.ts_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                cmd = { "typescript-language-server", "--stdio" },
            })
        end,
    },
}
