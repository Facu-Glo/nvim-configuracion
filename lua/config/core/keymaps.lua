local keymap = vim.keymap.set

------------------------------------------------------------------------------------------------

keymap("n", "<leader>qq", "<CMD>q<CR>", { desc = "Salir" })
keymap("n", "<leader>qa", "<CMD>qall!<CR>", { desc = "Salir sin guardar" })
keymap("n", "<leader>qw", "<CMD>wqall<CR>", { desc = "Guardar y salir" })

------------------------------------------------------------------------------------------------

-- [ NAVEGACIÓN Y VENTANAS ]
-- Salir de modos de forma rápida
keymap({ "i", "v" }, "<M-e>", "<ESC>")
keymap("t", "<M-e>", [[<C-\><C-n>]], { desc = "Escapar terminal" })

-- Movimiento entre splits (Normal y Terminal)
local directions = { h = "Izquierda", j = "Abajo", k = "Arriba", l = "Derecha" }
for key, desc in pairs(directions) do
    keymap("n", "<C-" .. key .. ">", "<C-w>" .. key, { desc = "Mover a la ventana " .. desc })
end

keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Mover abajo (terminal)" })
keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Mover arriba (terminal)" })

-- Creación de splits
keymap("n", "<leader>-", "<CMD>split<CR><C-w>j", { desc = "Split horizontal" })
keymap("n", "<leader>|", "<CMD>vsplit<CR><C-w>l", { desc = "Split vertical" })

-- Modificar tamaño de la ventana
keymap({ "n", "t" }, "<c-up>", "<cmd>resize +2<cr>", { desc = "aumentar la altura de la ventana" })
keymap({ "n", "t" }, "<c-down>", "<cmd>resize -2<cr>", { desc = "disminuir la altura de la ventana" })
keymap("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "disminuir el ancho de la ventana" })
keymap("n", "<c-right>", "<cmd>vertical resize +2<cr>", { desc = "aumentar el ancho de la ventana" })

keymap('n', '<C-W>d', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
end, { desc = "LSP: Definición en split horizontal" })

------------------------------------------------------------------------------------------------

-- [ EDICIÓN Y ARCHIVOS ]
-- Guardado rápido
keymap({ "n", "v" }, "<C-s>", "<CMD>w<CR>", { silent = true })
keymap("i", "<C-s>", "<Esc><CMD>w<CR>", { silent = true })

-- Selección total
keymap("n", "<leader>a", function()
    vim.cmd("keepjumps normal! ggVG")
end, { desc = "Select all" })

-- Cursor en el incio/fin de linea
keymap({ "n", "v" }, "<M-i>", "^", { noremap = true, silent = true, desc = "Ir al inicio de la linea" })
keymap({ "n", "v" }, "<M-f>", "$", { noremap = true, silent = true, desc = "Ir al final de la linea" })

------------------------------------------------------------------------------------------------

-- [ UI / TOGGLES ]
keymap({ "n", "v" }, "<leader>r", function()
    vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle números relativos" })

------------------------------------------------------------------------------------------------

-- Integracion con GIT
keymap("n", "<leader>gr", "<CMD>!gh repo view --web<CR>", { desc = "Abrir repositorio en github" })
keymap("n", "<leader>gp", "<CMD>!gh api user --jq '.html_url' | xargs xdg-open<CR>", { desc = "Abrir perfil en github" })

------------------------------------------------------------------------------------------------

keymap("v", "gq", function()
    local buf = vim.api.nvim_get_current_buf()
    local old = vim.bo[buf].formatexpr

    vim.bo[buf].formatexpr = ""

    vim.cmd("normal! gq")

    vim.bo[buf].formatexpr = old
end)

------------------------------------------------------------------------------------------------

-- Ejecutar el ultimo comando ejecutado
keymap("n", "|", "<CMD>@:<CR>")

------------------------------------------------------------------------------------------------

-- Limpiar la cmd
keymap("n", "<Esc>", function()
    vim.cmd("nohlsearch")
    vim.cmd("echo ''")
end, { desc = "Limpiar búsqueda" })

keymap("n", "<M-e>", function()
    vim.cmd("nohlsearch")
    vim.cmd("echo ''")
end, { desc = "Limpiar búsqueda" })

------------------------------------------------------------------------------------------------

-- Manejo de buffers
keymap("n", "<leader>bl", function()
    local cur_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buflisted and buf < cur_buf then
            vim.api.nvim_buf_delete(buf, { force = false })
        end
    end
end, { desc = "Cerrar Buffers a izquierda" })

keymap("n", "<leader>br", function()
    local cur_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buflisted and buf > cur_buf then
            vim.api.nvim_buf_delete(buf, { force = false })
        end
    end
end, { desc = "Cerrar Buffers a derecha" })

keymap("n", "<leader>bd", "<CMD>bd %<CR>", { desc = "Cerrar buffer/ventana actual" })

keymap("n", "<S-h>", "<cmd>bprev<cr>", { desc = "Next Buffer" })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Prev Buffer" })

