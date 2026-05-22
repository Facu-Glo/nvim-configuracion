vim.pack.add({
    { src = "https://github.com/folke/sidekick.nvim.git" },
})

require("sidekick").setup({
    cli = {
        picker = "snacks",
        win = {
            layout = "right",
            split = { width = 80 },
        },
    },
})

vim.keymap.set({ "n" }, "<leader>ia", function()
    require("sidekick.cli").toggle()
end, { desc = "Sidekick Toggle" })

vim.keymap.set({ "n", "x" }, "<leader>is", function()
    require("sidekick.cli").select({ filter = { installed = true } })
end, { desc = "Sidekick Select CLI" })

vim.keymap.set({ "n", "x" }, "<leader>ip", function()
    require("sidekick.cli").prompt()
end, { desc = "Sidekick Prompt" })

vim.keymap.set({ "n", "x" }, "<leader>it", function()
    require("sidekick.cli").send({ msg = "{this}" })
end, { desc = "Sidekick Send This" })

vim.keymap.set("x", "<leader>iv", function()
    require("sidekick.cli").send({ msg = "{selection}" })
end, { desc = "Sidekick Send Selection" })

vim.keymap.set("n", "<leader>if", function()
    require("sidekick.cli").send({ msg = "{file}" })
end, { desc = "Sidekick Send File" })
