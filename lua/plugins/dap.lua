vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-dap.git",           version = "master" },
    { src = "https://github.com/igorlfs/nvim-dap-view.git",           version = "v1.1.1" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text.git", version = "master" },
    { src = "https://github.com/mfussenegger/nvim-dap-python.git",    version = "master" },
})

local dap = require("dap")
local dap_view = require("dap-view")

dap_view.setup({
    auto_toggle = true,
    windows = {
        position = "right",
        size = 0.5,
    },
    winbar = {
        sections = { "watches", "scopes", "breakpoints", "threads", "repl", "console" },
        show_keymap_hints = false,
        controls = {
            enabled = true,
        },
    },
})

require("nvim-dap-virtual-text").setup()

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticHint", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "󰁕", texthl = "DiagnosticOK", linehl = "FormatChanged", numhl = "" })

-- Python
require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

-- JavaScript / TypeScript
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
        },
    },
}

for _, lang in ipairs({ "javascript", "typescript" }) do
    dap.configurations[lang] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
    }
end

-- Keymaps
local map = vim.keymap.set

map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
map("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "DAP: Conditional breakpoint" })
map("n", "<F5>", dap.continue, { desc = "DAP: Continue/Start" })
map("n", "<leader>dc", dap.continue, { desc = "DAP: Continue/Start" })
map("n", "<F10>", dap.step_over, { desc = "DAP: Step over" })
map("n", "<leader>do", dap.step_over, { desc = "DAP: Step over" })
map("n", "<F11>", dap.step_into, { desc = "DAP: Step into" })
map("n", "<leader>di", dap.step_into, { desc = "DAP: Step into" })
map("n", "<F12>", dap.step_out, { desc = "DAP: Step out" })
map("n", "<leader>dO", dap.step_out, { desc = "DAP: Step out" })
map("n", "<leader>dt", dap.terminate, { desc = "DAP: Terminate" })
map("n", "<leader>dd", function()
    dap_view.toggle()
end, { desc = "DAP: Toggle view" })
map({ "n", "v" }, "<leader>dh", function()
    dap_view.hover()
end, { desc = "DAP: Hover" })
