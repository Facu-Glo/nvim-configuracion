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
                "bash-language-server",
                "clangd",
                "gopls",
                "jdtls",
                "css-lsp",
                "marksman",
                "ruff",
                "typescript-language-server",
                "prettier",
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
            -- ✨ CONFIGURACIÓN DE DIAGNÓSTICOS (Como Error Lens de VSCode)
            vim.diagnostic.config({
                virtual_text = {
                    enabled = true,
                    source = "if_many",
                    spacing = 4,
                    prefix = "●",
                    format = function(diagnostic)
                        local source = diagnostic.source and (" [" .. diagnostic.source .. "]") or ""
                        return string.format(" %s%s", diagnostic.message, source)
                    end,
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "✗",
                        [vim.diagnostic.severity.WARN] = "⚠",
                        [vim.diagnostic.severity.INFO] = "ℹ",
                        [vim.diagnostic.severity.HINT] = "💡",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "if_many",
                    header = "",
                    prefix = "",
                },
            })
            -- Configuración de nvim-lspconfig
            local lspconfig = require("lspconfig")
            -- local navic = require("nvim-navic")

            -- Habilitar capacidades de autocompletado
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Keybindings
            local on_attach = require("plugins.config.lsp.on_attach")

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
                            globals = { "vim" },
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
            -- Configuracion en nvim-jdtls

            -- Configuración para Lemminx (XML)
            lspconfig.lemminx.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

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
