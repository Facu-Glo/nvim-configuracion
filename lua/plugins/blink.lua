return {
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            "fang2hou/blink-copilot"
            -- 'giuxtaposition/blink-cmp-copilot',
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
                -- default = function()
                --     local ft = vim.bo.filetype
                --     if ft == 'oil' then
                --         -- For oil.nvim, we don't want to use Codeium or Copilot
                --         return { 'lsp', 'path', 'snippets', 'buffer' }
                --     else
                --         return { 'copilot', 'lsp', 'path', 'snippets', 'buffer' }
                --     end
                -- end,

                default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'codeium' },
                per_filetype = {
                    markdown = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'codeium' },
                    oil = { 'lsp', 'path', 'snippets', 'buffer' },
                },
                providers = {
                    codeium = {
                        name = 'Codeium',
                        module = 'codeium.blink',
                        async = true,
                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
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
