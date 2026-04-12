vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/site")

local ts = require('nvim-treesitter')

ts.setup {
    install_dir = vim.fn.stdpath('data') .. '/site'
}

local my_langs = {
    "bash", "html", "javascript", "json", "java", "lua",
    "markdown", "markdown_inline", "python", "query", "regex",
    "tsx", "typescript", "vim", "yaml", "xml", "c", "rust", "latex",
}
ts.install(my_langs)

vim.api.nvim_create_autocmd("FileType", {
    pattern = my_langs,
    callback = function(args)
        vim.treesitter.start()

        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldlevel = 99

        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
