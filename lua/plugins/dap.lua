vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-dap.git",           version = "master" },
    { src = "https://github.com/igorlfs/nvim-dap-view.git",           version = vim.version.range("1.*") },
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
        terminal = {
            position = "below",
            size = 0.4,
        }
    },
    winbar = {
        sections = { "watches", "scopes", "breakpoints", "threads", "repl" },
        default_section = "scopes",
        show_keymap_hints = true,
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

-- Rust / C / C++ (codelldb)
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
    },
}

dap.configurations.rust = {
    {
        name = "Launch Rust",
        type = "codelldb",
        request = "launch",
        program = function()
            local cwd = vim.fn.getcwd()
            local cargo_toml = cwd .. "/Cargo.toml"
            local project_name

            if vim.fn.filereadable(cargo_toml) == 1 then
                local content = table.concat(vim.fn.readfile(cargo_toml), "\n")
                project_name = content:match('%[%[bin%s*%]%s*\nname%s*=%s*"([^"]+)"')
                    or content:match('%[package%]%s*\nname%s*=%s*"([^"]+)"')
            end

            if not project_name then
                project_name = vim.fn.fnamemodify(cwd, ":t")
            end

            local default_path = cwd .. "/target/debug/" .. project_name

            local choice = vim.fn.input("Binario: ", default_path, "file")
            return (choice ~= "") and choice or default_path
        end,
        cwd = "${workspaceFolder}",
    },
}
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
    dap_view.toggle({ force = true })
end, { desc = "DAP: Toggle view" })
map({ "n", "v" }, "<leader>dh", function()
    require("dap-view").hover()
end, { desc = "DAP: Hover" })
