vim.pack.add({
    { src = "https://github.com/jake-stewart/multicursor.nvim.git", version = "1.0" },
})

local mc = require("multicursor-nvim")
mc.setup()

local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { link = "Cursor" })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorMatchPreview", { link = "Search" })
hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })

------------------------------------------------------------------------------------------------
-- Añadir cursores arriba/abajo
vim.keymap.set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end, { desc = "Cursor arriba" })
vim.keymap.set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end, { desc = "Cursor abajo" })

-- Match por palabras
vim.keymap.set({ "n", "x" }, "<leader>mn", function() mc.matchAddCursor(1) end, { desc = "Siguiente coincidencia" })
vim.keymap.set({ "n", "x" }, "<leader>ms", function() mc.matchSkipCursor(1) end, { desc = "Saltar y siguiente" })
vim.keymap.set({ "n", "x" }, "<leader>mA", mc.matchAllAddCursors, { desc = "Todas las coincidencias" })

-- Operadores (iw, ap, etc)
vim.keymap.set({ "n", "x" }, "mw", function() mc.operator({ motion = "iw", visual = true }) end)
vim.keymap.set("n", "mW", mc.operator)

-- Gestión de cursores
vim.keymap.set({ "n", "x" }, "<left>", mc.prevCursor, { desc = "Cursor anterior" })
vim.keymap.set({ "n", "x" }, "<right>", mc.nextCursor, { desc = "Cursor siguiente" })
vim.keymap.set({ "n", "x" }, "<leader>mx", mc.deleteCursor, { desc = "Eliminar cursor actual" })
vim.keymap.set({ "n", "x" }, "<leader>mq", mc.clearCursors, { desc = "Limpiar cursores" })
vim.keymap.set({ "n", "x" }, "<leader>ma", mc.toggleCursor, { desc = "Agregar cursor" })
vim.keymap.set("n", "<leader>me", mc.enableCursors, { desc = "Activar los cursores" })

-- Integracion con mouse
vim.keymap.set("n", "<m-leftmouse>", mc.handleMouse)
vim.keymap.set("n", "<m-leftdrag>", mc.handleMouseDrag)
vim.keymap.set("n", "<m-leftrelease>", mc.handleMouseRelease)

vim.keymap.set("x", "S", mc.splitCursors, { desc = "Split por regex" })
vim.keymap.set("x", "I", mc.insertVisual, { desc = "Insertar en selección" })
vim.keymap.set("x", "A", mc.appendVisual, { desc = "Append en selección" })

vim.keymap.set("n", "<Esc>", function()
    if mc.hasCursors() then
        mc.clearCursors()
    else
        vim.cmd("nohlsearch")
    end
end, { desc = "Limpiar búsqueda y cursores" })
