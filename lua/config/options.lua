local nvim          = vim.opt

nvim.termguicolors  = true
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
nvim.textwidth      = 80
nvim.formatoptions:remove("t")
nvim.foldtext  = ""
nvim.fillchars = {
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
}
