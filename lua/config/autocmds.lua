local autocmd = vim.api.nvim_create_autocmd

vim.cmd [[
  highlight YankHighlight guibg=#f18e5d guifg=#1e1e2e
]]

autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "YankHighlight",
            timeout = 200,
        })
    end,
})


autocmd("FileType", {
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.spell = true
    end,
})

autocmd("FileType", {
    pattern = "html",
    callback = function()
        vim.keymap.set(
            "n",
            "<A-s>a",
            ":LiveServerStart<CR>",
            { noremap = true, silent = true, buffer = true, desc = "Iniciar Live Server" }
        )
        vim.keymap.set(
            "n",
            "<A-s>d",
            ":LiveServerStop<CR>",
            { noremap = true, silent = true, buffer = true, desc = "Desactivar Live Server" }
        )
    end,
})
