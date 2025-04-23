return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "leoluz/nvim-dap-go",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        vim.fn.sign_define("DapBreakpoint", {
            text = "●",
            texthl = "DiagnosticError",
            linehl = "",
            numhl = "",
        })

        dapui.setup()

        require("nvim-dap-virtual-text").setup({
            commented = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
        })

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Adaptador para C
        dap.adapters.codelldb = {
            type = "server",
            port = 2088,
            executable = {
                command = "codelldb",
                args = { "--port", "2088" },
            },
            env = {
                LLDB_FOLLOW_FORK_MODE = "child",
            },
        }

        -- Configuración de la depuración para C/C++
        dap.configurations.c = {
            {
                name = "Launch C Program",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtEntry = true,
                args = function()
                    local input = vim.fn.input("Program arguments: ")
                    if input == "" then
                        return nil
                    end
                    return vim.fn.split(input, " ", true)
                end,
            },
        }

        -- Configuración de la depuración para C++ (puedes usar la misma configuración)
        dap.configurations.cpp = dap.configurations.c

        -- Adaptador para Python
        dap.adapters.python = {
            type = "executable",
            command = "python",
            args = { "-m", "debugpy.adapter" },
        }

        dap.configurations.python = {
            {
                type = "python",
                request = "launch",
                name = "Launch Python file",
                program = "${file}",
                pythonPath = function()
                    return "python"
                end,
            },
        }

        -- Adaptador para Golang
        require("dap-go").setup()

        --
        local map = vim.keymap.set
        map("n", "<F5>", function()
            dap.continue()
        end, { desc = "DAP Continue" })
        map("n", "<F10>", function()
            dap.step_over()
        end, { desc = "DAP Step Over" })
        map("n", "<F11>", function()
            dap.step_into()
        end, { desc = "DAP Step Into" })
        map("n", "<F12>", function()
            dap.step_out()
        end, { desc = "DAP Step Out" })
        map("n", "<Leader>db", function()
            dap.toggle_breakpoint()
        end, { desc = "Toggle Breakpoint" })
        map("n", "<Leader>du", function()
            dapui.toggle()
        end, { desc = "Toggle DAP UI" })
    end,
}
