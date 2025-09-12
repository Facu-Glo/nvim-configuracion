local nvim = vim.o

nvim.number         = true
nvim.relativenumber = true
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
nvim.foldmethod     = "expr"
nvim.foldexpr       = "nvim_treesitter#foldexpr()"
nvim.foldlevel      = 99

vim.cmd.colorscheme("tokyonight-night")
