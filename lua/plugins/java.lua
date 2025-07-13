return {
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        dependencies = {
            "neovim/nvim-lspconfig",
        },

        config = function()
            local jdtls = require("jdtls")
            local on_attach = require("plugins.config.lsp.on_attach")

            -- Función para configurar JDTLS
            local function setup_jdtls()
                local home = os.getenv("HOME")
                local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
                local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
                local workspace_dir = workspace_path .. project_name

                -- Configuración del servidor
                local config = {
                    cmd = {
                        "jdtls",
                        "-data", workspace_dir,
                    },
                    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
                    settings = {
                        java = {
                            eclipse = {
                                downloadSources = true,
                            },
                            configuration = {
                                updateBuildConfiguration = "interactive",
                            },
                            maven = {
                                downloadSources = true,
                            },
                            implementationsCodeLens = {
                                enabled = true,
                            },
                            referencesCodeLens = {
                                enabled = true,
                            },
                            references = {
                                includeDecompiledSources = true,
                            },
                            format = {
                                enabled = true,
                                settings = {
                                    url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
                                    profile = "GoogleStyle",
                                },
                            },
                        },
                        signatureHelp = { enabled = true },
                        completion = {
                            favoriteStaticMembers = {
                                "org.hamcrest.MatcherAssert.assertThat",
                                "org.hamcrest.Matchers.*",
                                "org.hamcrest.CoreMatchers.*",
                                "org.junit.jupiter.api.Assertions.*",
                                "java.util.Objects.requireNonNull",
                                "java.util.Objects.requireNonNullElse",
                                "org.mockito.Mockito.*",
                            },
                        },
                        contentProvider = { preferred = "fernflower" },
                        extendedClientCapabilities = jdtls.extendedClientCapabilities,
                        sources = {
                            organizeImports = {
                                starThreshold = 9999,
                                staticStarThreshold = 9999,
                            },
                        },
                        codeGeneration = {
                            toString = {
                                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                            },
                            useBlocks = true,
                        },
                    },
                    flags = {
                        allow_incremental_sync = true,
                    },
                    init_options = {
                        bundles = {},
                        settings = {
                            java = {
                                imports = {
                                    gradle = {
                                        wrapper = {
                                            checksums = {
                                                {
                                                    sha256 =
                                                    "7d3a4ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172",
                                                    allowed = true
                                                }
                                            },
                                        }
                                    }
                                }
                            }
                        }
                    },
                    capabilities = require("blink.cmp").get_lsp_capabilities(),
                    on_attach = function(client, bufnr)
                        on_attach(client, bufnr)
                        local bufopts = { noremap = true, silent = true, buffer = bufnr }

                        vim.keymap.set("n", "<leader>jo", jdtls.organize_imports,
                            vim.tbl_extend("force", bufopts, { desc = "Organizar imports" }))
                        vim.keymap.set("n", "<leader>jv", jdtls.extract_variable,
                            vim.tbl_extend("force", bufopts, { desc = "Extraer variable" }))
                        vim.keymap.set("n", "<leader>jc", jdtls.extract_constant,
                            vim.tbl_extend("force", bufopts, { desc = "Extraer constante" }))
                        vim.keymap.set("n", "<leader>jm", jdtls.extract_method,
                            vim.tbl_extend("force", bufopts, { desc = "Extraer método" }))
                    end,
                }

                -- Inicializar JDTLS
                jdtls.start_or_attach(config)
            end

            -- Autocommand para configurar JDTLS cuando se abra un archivo Java
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = setup_jdtls,
            })
        end,
    },
}
