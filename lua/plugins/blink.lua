vim.pack.add({
        { src = 'https://github.com/Saghen/blink.cmp', version = vim.version.range('*') },
        { src = 'https://github.com/rafamadriz/friendly-snippets' }
    })

local cmp = require('blink.cmp')

cmp.setup({
    keymap = {
        preset        = "default",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"]     = { "hide" },
        ["<CR>"]      = { "accept", "fallback" },
        ["<Tab>"]     = { "snippet_forward", "fallback" },
        ["<S-Tab>"]   = { "snippet_backward", "fallback" },
        ["<C-k>"]     = { "select_prev", "fallback" },
        ["<C-j>"]     = { "select_next", "fallback" },
        ["<C-b>"]     = { "scroll_documentation_up", "fallback" },
        ["<C-f>"]     = { "scroll_documentation_down", "fallback" },
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
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
        ghost_text = { enabled = true },
    },
})

