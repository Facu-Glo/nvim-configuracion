local nvim          = vim.o

nvim.number         = true
nvim.relativenumber = false
nvim.expandtab      = true
nvim.tabstop        = 4
nvim.shiftwidth     = 4
nvim.softtabstop    = 4
nvim.clipboard      = "unnamedplus"
nvim.ignorecase     = true
nvim.smartcase      = true
nvim.undofile       = true
nvim.spelllang      = "es,en"
nvim.spell          = false
nvim.cursorline     = true
nvim.wrap           = false
nvim.showmode       = false
nvim.splitright     = true
nvim.textwidth      = 100
vim.opt.foldexpr    = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldmethod  = 'expr'
vim.wo.foldlevel    = 99
vim.opt.foldtext    = ""
vim.opt.fillchars   = {
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
}
vim.cmd.colorscheme("tokyonight-night")
