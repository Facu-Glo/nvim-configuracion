return {
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'giuxtaposition/blink-cmp-copilot',
        },

        version = '1.*',
        opts = {

            keymap = {
                preset = 'default',
                ["<CR>"] = { "accept_and_enter", "fallback" },
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
            },

            cmdline = {
                keymap = {
                    preset = 'inherit',
                    ['<CR>'] = { 'fallback' },
                    ['<Tab>'] = { 'accept' },
                },
                completion = {
                    menu = {
                        auto_show = true
                    },
                },
            },

            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = {
                menu = {
                    draw = {
                        columns = {
                            { "label",     "label_description", gap = 2 },
                            { "kind_icon", "kind",              gap = 1 },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                },
            },

            sources = {
                default = { 'codeium', 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    codeium = {
                        name = 'Codeium',
                        module = 'codeium.blink',
                        async = true,
                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    }
}
