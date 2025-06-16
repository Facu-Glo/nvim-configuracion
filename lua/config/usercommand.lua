vim.api.nvim_create_user_command("TabPick", function()
    vim.cmd("tabnew")
    require("snacks.picker").files()
end, { desc = "Abrir archivo en nueva pestaña con snacks.picker.files" })
