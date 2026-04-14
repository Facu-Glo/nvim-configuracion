vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "main" },
})

vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/site")

local my_langs = {
    "bash", "html", "javascript", "json", "java", "lua",
    "markdown", "markdown_inline", "python", "query", "regex",
    "tsx", "typescript", "vim", "yaml", "xml", "c", "rust", "latex",
}

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    once = true,
    callback = function()
        local ts = require('nvim-treesitter')

        ts.setup {
            install_dir = vim.fn.stdpath('data') .. '/site'
        }

        ts.install(my_langs)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = my_langs,
    callback = function(args)
        vim.treesitter.start()

        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldlevel = 99

        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
