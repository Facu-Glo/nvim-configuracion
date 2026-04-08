local keymap = vim.keymap.set
vim.g.mapleader = " "

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

-- [ EDICIÓN Y ARCHIVOS ]
-- Guardado rápido
keymap({ "n", "v" }, "<C-s>", "<CMD>w<CR>", { silent = true })
keymap("i", "<C-s>", "<Esc><CMD>w<CR>", { silent = true })

-- Selección total
keymap("n", "<leader>a", function()
    vim.cmd("keepjumps normal! ggVG")
end, { desc = "Seleccionar todo" })

-- Cerrar buffer
keymap("n", "<leader>bd", "<CMD>bd %<CR>", { desc = "Cerrar buffer/ventana actual" })

-- Cursor en el incio/fin de linea
keymap({ "n", "v" }, "<M-i>", "^", { noremap = true, silent = true, desc = "Ir al inicio de la linea" })
keymap({ "n", "v" }, "<M-f>", "$", { noremap = true, silent = true, desc = "Ir al final de la linea" })
keymap({ "n", "v" }, "<leader>0", "^", { noremap = true, silent = true, desc = "Ir al inicio de la linea" })
keymap({ "n", "v" }, "<leader>9", "$", { noremap = true, silent = true, desc = "Ir al final de la linea" })

-- Toggle wrap
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

-- [ UI / TOGGLES ]
keymap({ "n", "v" }, "<leader>r", function()
    vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle números relativos" })

-- [ DIAGNÓSTICOS (TROUBLE) ]
-- Agrupamos bajo la letra 'x' de eXtra o eXceptional
keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
keymap("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols" })
keymap("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "LSP Definitions / references (Trouble)" })
keymap("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
keymap("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Formatear archivo (Llama a conform)
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Formatear archivo o selección" })

-- [ FYLER ]
vim.keymap.set({ "n", "v" }, "-", function()
    require("fyler").toggle({ kind = "float" })
end, { desc = "Abrir Fyler" })


-- [ MULTICURSOR: NAVEGACIÓN Y EDICIÓN ]
local mc = require("multicursor-nvim")

-- Añadir cursores arriba/abajo
keymap({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end, { desc = "Cursor arriba" })
keymap({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end, { desc = "Cursor abajo" })

-- Match por palabras
keymap({ "n", "x" }, "<leader>mn", function() mc.matchAddCursor(1) end, { desc = "Siguiente coincidencia" })
keymap({ "n", "x" }, "<leader>ms", function() mc.matchSkipCursor(1) end, { desc = "Saltar y siguiente" })
keymap({ "n", "x" }, "<leader>mA", mc.matchAllAddCursors, { desc = "Todas las coincidencias" })

-- Operadores (iw, ap, etc)
keymap({ "n", "x" }, "mw", function() mc.operator({ motion = "iw", visual = true }) end)
keymap("n", "mW", mc.operator)

-- Gestión de cursores
keymap({ "n", "x" }, "<left>", mc.prevCursor, { desc = "Cursor anterior" })
keymap({ "n", "x" }, "<right>", mc.nextCursor, { desc = "Cursor siguiente" })
keymap({ "n", "x" }, "<leader>mx", mc.deleteCursor, { desc = "Eliminar cursor actual" })
keymap({ "n", "x" }, "<leader>mq", mc.clearCursors, { desc = "Limpiar cursores" })
keymap({ "n", "x" }, "<leader>ma", mc.toggleCursor, { desc = "Agregar cursor" })
keymap("n", "<leader>me", mc.enableCursors, { desc = "Activar los cursores" })

-- Acciones visuales
keymap("x", "S", mc.splitCursors, { desc = "Split por regex" })
keymap("x", "I", mc.insertVisual, { desc = "Insertar en selección" })
keymap("x", "A", mc.appendVisual, { desc = "Append en selección" })

-- [ ESCAPE INTELIGENTE ]
keymap("n", "<Esc>", function()
    if mc.hasCursors() then
        mc.clearCursors()
    else
        vim.cmd("nohlsearch")
    end
end, { desc = "Limpiar búsqueda y cursores" })

-- [ SNACKS ]
keymap("n", "<leader><space>", function() Snacks.picker.files() end, { desc = "Buscar archivos" })
keymap("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
keymap("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Grep" })
keymap("n", "<leader>fn", function() Snacks.picker.notifications() end, { desc = "History" })
keymap("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Help" })
keymap("n", "<leader>fz", function() Snacks.picker.zoxide() end, { desc = "Zoxide" })
keymap("n", "<leader>fl", function() Snacks.picker.lines() end, { desc = "Buscar lineas" })
keymap("n", "<leader>f:", function() Snacks.picker.command_history() end, { desc = "Command History" })
keymap("n", "<leader>fd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostico" })
keymap("n", "<leader>fr", function() Snacks.picker.registers() end, { desc = "Registros" })
keymap("n", "<leader>fu", function() Snacks.picker.undo() end, { desc = "Undo" })
keymap("n", "<leader>fi", function() Snacks.picker.icons() end, { desc = "Icons" })
keymap("n", "<leader>cs", function() Snacks.picker.lsp_symbols() end, { desc = "Lsp symbols" })
keymap("n", "<leader>fc", function() Snacks.picker.colorschemes() end, { desc = "colorscheme" })
keymap("n", "<leader>fm", function() Snacks.picker.marks() end, { desc = "Marks" })

-- Git
keymap("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
keymap("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
keymap({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
keymap("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })

-- Buffers & Utils
keymap("n", "<leader>bc", function() Snacks.bufdelete() end, { desc = "Eliminar buffer" })
keymap("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Eliminar otros" })
keymap("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })

-- Terminal
keymap({ "n", "t" }, "<leader>tt", function() Snacks.terminal.toggle(nil, { cwd = vim.fn.getcwd() }) end,
    { desc = "Terminal Toggle" })
keymap({ "n", "t" }, "<leader>ty", function() Snacks.terminal("zsh") end, { desc = "Terminal Zsh" })

-- [ NAVEGACIÓN RÁPIDA (FLASH.NVIM) ]
-- Salto normal (reemplaza 's' y 'S')
keymap({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash Jump" })
keymap({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
keymap("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
keymap({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })

-- [BUFFERLINE]
keymap("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
keymap("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
keymap("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
keymap("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
keymap("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
keymap("n", "<TAB>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
keymap("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
keymap("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
keymap("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
keymap("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })
keymap("n", "gb", "<CMD>BufferLinePick<CR>", { desc = "Pick Buffer" })
keymap("n", "gD", "<CMD>BufferLinePickClose<CR>", { desc = "Pick Buffer Close" })

-- Integracion con GIT
keymap("n", "<leader>gr", "<CMD>!gh repo view --web<CR>", { desc = "Abrir repositorio en github" })
keymap("n", "<leader>gp", "<CMD>!gh api user --jq '.html_url' | xargs xdg-open<CR>", { desc = "Abrir perfil en github" })
