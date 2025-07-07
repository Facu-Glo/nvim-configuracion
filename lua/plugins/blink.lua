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
                ["<CR>"] = { "accept", "fallback" },
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
            },
            cmdline = {
                keymap = { preset = 'inherit' },
                completion = {
                    menu = { auto_show = true },
                },
            },

            appearance = {
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = { auto_show = true }
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'codeium', 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    codeium = {
                        name = 'Codeium',
                        module = 'codeium.blink',
                        async = true,
                        transform_items = function(ctx, items)
                            for _, item in ipairs(items) do
                                item.kind_icon = '󰚩 '
                                item.kind_name = 'Codeium'
                            end
                            return items
                        end,
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
