local keymap = vim.keymap.set

keymap({ "i", "v" }, "<M-e>", "<ESC>")
keymap("t", "<M-e>", "<C-\\><C-n>", { noremap = true, silent = true })

keymap("n", "<leader>a", function()
    vim.cmd("keepjumps normal! ggVG")
end, { desc = "Seleccionar todo el archivo" })

keymap("n", "<C-h>", "<C-w>h", { desc = "Mover a la ventana izquierda" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Mover a la ventana abajo" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Mover a la ventana arriba" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Mover a la ventana derecha" })
keymap("t", '<C-j>', '<C-\\><C-n><C-w>j',
    { desc = 'Mover a la ventana de abajo (terminal)', noremap = true, silent = true })
keymap("t", '<C-k>', '<C-\\><C-n><C-w>k',
    { desc = 'Mover a la ventana de arriba (terminal)', noremap = true, silent = true })
keymap("n", "<leader>-", "<CMD>split<CR><C-w>j", { desc = "Split horizontal" })
keymap("n", "<leader>|", "<CMD>vsplit<CR><C-w>l", { desc = "Split vertical" })
keymap("n", "<leader>wc", "<C-w>c", { desc = "Cerrar la ventana" })

keymap({ "n", "v" }, "<C-s>", ":w<CR>", { noremap = true, silent = true })
keymap("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true })

keymap("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
keymap("n", "<leader>oo", "<CMD>Oil<CR>", { desc = "Abrir Oil" })
keymap("n", "<leader>of", "<CMD>Oil --float<CR>", { desc = "Abrir Oil flotante" })

keymap("n", "<leader>cf", "<CMD>lua vim.lsp.buf.format()<CR>")
keymap("n", "<leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>")

keymap({ "n", "t" }, "<c-up>", "<cmd>resize +2<cr>", { desc = "aumentar la altura de la ventana" })
keymap({ "n", "t" }, "<c-down>", "<cmd>resize -2<cr>", { desc = "disminuir la altura de la ventana" })
keymap("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "disminuir el ancho de la ventana" })
keymap("n", "<c-right>", "<cmd>vertical resize +2<cr>", { desc = "aumentar el ancho de la ventana" })

keymap("n", "<A-z>", function()
    local wrap_enabled = vim.wo.wrap
    vim.wo.wrap = not wrap_enabled
    vim.wo.breakindent = not wrap_enabled
    vim.wo.linebreak = not wrap_enabled

    if wrap_enabled then
        print("Wrap desactivado")
    else
        print("Wrap activado")
    end
end, { desc = "Alternar ajuste de línea con Alt+Z" })

keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

keymap("n", "j", "gj", { noremap = true, silent = true })
keymap("n", "k", "gk", { noremap = true, silent = true })

keymap({ "n", "v" }, "<leader>0", "^", { noremap = true, silent = true, desc = "Ir al inicio de la linea" })
keymap({ "n", "v" }, "<M-i>", "^", { noremap = true, silent = true, desc = "Ir al inicio de la linea" })
keymap({ "n", "v" }, "<leader>9", "$", { noremap = true, silent = true, desc = "Ir al final de la linea" })
keymap({ "n", "v" }, "<M-f>", "$", { noremap = true, silent = true, desc = "Ir al final de la linea" })

----
keymap("n", "<leader>qs", function() require("persistence").load() end,
    { desc = "Cargar la sesión para el directorio actual" })

keymap("n", "<leader>qS", function() require("persistence").select() end,
    { desc = "Seleccionar una sesión para cargar" })

keymap("n", "<leader>ql", function() require("persistence").load({ last = true }) end,
    { desc = "Cargar la última sesión" })

keymap("n", "<leader>qd", function() require("persistence").stop() end,
    { desc = "Detener la persistencia => la sesión no se guardará al salir" })

keymap("n", "<leader>ra", function()
    vim.opt.relativenumber = true
end, { desc = "Activar números relativos" })

keymap("n", "<leader>rd", function()
    vim.opt.relativenumber = false
end, { desc = "Desactivar números relativos" })

keymap("v", ">", ">gv", { noremap = true })
keymap("v", "<", "<gv", { noremap = true })

keymap("n", "<leader>qq", "<CMD>qall<CR>", { desc = "Salir sin guardar" })
keymap("n", "<leader>qw", "<CMD>wqall<CR>", { desc = "Guardar y salir" })

-- vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
-- vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Mover selección abajo", silent = true })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Mover selección arriba", silent = true })
