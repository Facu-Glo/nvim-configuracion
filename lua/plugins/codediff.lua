vim.pack.add({
    { src = "https://github.com/esmuellert/codediff.nvim.git" }
})

require("codediff").setup({})

vim.keymap.set({ "n", "v" }, "<leader>gd", "<CMD>CodeDiff<CR>", { desc = "Code Diff" })
