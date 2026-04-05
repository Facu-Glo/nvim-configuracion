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
nvim.textwidth      = 80
vim.opt.formatoptions:remove("t")
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1f2335" })

vim.opt.foldexpr   = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldmethod = 'expr'
vim.wo.foldlevel   = 99
vim.opt.foldtext   = ""
vim.opt.fillchars  = {
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
}
vim.cmd.colorscheme("tokyonight-night")
