return {
    {
        "mason-org/mason.nvim",
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
                "vtsls",
                "prettier",
                "elixir-ls"
            }

            for _, name in ipairs(ensure_installed) do
                local ok, pkg = pcall(mr.get_package, name)
                if not ok then
                    vim.notify("Fallo al obtener: " .. name, vim.log.levels.ERROR)
                elseif not pkg:is_installed() then
                    vim.notify("Instalando: " .. name)
                    pkg:install()
                end
            end
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "saghen/blink.cmp",
            -- "williamboman/mason-lspconfig.nvim",
            -- "SmiteshP/nvim-navic",
        },
        opts = function()
            local ret = {
                -- Configuración de diagnósticos (Como Error Lens de VSCode)
                diagnostics = {
                    virtual_text = {
                        enabled = true,
                        source = "if_many",
                        spacing = 4,
                        prefix = "●",
                    },
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = " ",
                            [vim.diagnostic.severity.WARN] = " ",
                            [vim.diagnostic.severity.INFO] = " ",
                            [vim.diagnostic.severity.HINT] = " ",
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
                },

                -- Configuración de capacidades globales
                capabilities = {
                    workspace = {
                        fileOperations = {
                            didRename = true,
                            willRename = true,
                        },
                    },
                },

                -- Configuración de servidores LSP
                servers = {
                    lua_ls = {
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        -- Make the server aware of Neovim runtime files
                                        vim.env.VIMRUNTIME,
                                        vim.fn.stdpath("config"),
                                    },
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    },

                    pyright = {
                        settings = {
                            python = {
                                analysis = {
                                    autoImportCompletions = true,
                                    diagnosticMode = "openFilesOnly",
                                },
                            },
                        },
                    },

                    marksman = {
                        root_dir = function()
                            return vim.fn.getcwd()
                        end,
                    },

                    -- ts_ls = {
                    -- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                    -- 	cmd = { "typescript-language-server", "--stdio" },
                    -- },
                    vtsls = {
                        -- Configuración para vtsls
                        settings = {
                            complete_function_calls = true,
                            vtsls = {
                                enableMoveToFileCodeAction = true,
                                autoUseWorkspaceTsdk = true,
                                experimental = {
                                    completion = {
                                        enableServerSideFuzzyMatch = true,
                                    },
                                },
                            },
                            typescript = {
                                updateImportsOnFileMove = { enabled = "always" },
                                suggest = {
                                    completeFunctionCalls = true,
                                },
                                inlayHints = {
                                    enumMemberValues = { enabled = true },
                                    functionLikeReturnTypes = { enabled = true },
                                    parameterNames = { enabled = "literals" },
                                    parameterTypes = { enabled = true },
                                    propertyDeclarationTypes = { enabled = true },
                                    variableTypes = { enabled = false },
                                },
                            },
                        },
                    },

                    rust_analyzer = {},

                    bashls = {},

                    clangd = {},

                    gopls = {},

                    lemminx = {},

                    cssls = {},

                    elixirls = {
                        cmd = {"/home/facu/.local/share/nvim/mason/packages/elixir-ls/language_server.sh"}
                    },
                },

                setup = {},
            }
            return ret
        end,

        config = function(_, opts)
            -- Configurar diagnósticos
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            -- Obtener capacidades de blink.cmp
            local has_blink, blink = pcall(require, "blink.cmp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_blink and blink.get_lsp_capabilities() or {},
                opts.capabilities or {}
            )

            -- Función para configurar servidores
            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                    on_attach = require("plugins.config.lsp.on_attach"),
                }, opts.servers[server] or {})

                if server_opts.enabled == false then
                    return
                end

                -- Aplicar configuración personalizada si existe
                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end

                require("lspconfig")[server].setup(server_opts)
            end

            -- Configurar todos los servidores
            for server, _ in pairs(opts.servers) do
                setup(server)
            end
        end,
    },
}
