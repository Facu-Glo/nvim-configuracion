local M = {}

local pick_mode = false
local pick_map = {}
local pick_buffers = {}
local pick_alphabet = "1234567890"

local function refresh_pick_data()
    pick_map, pick_buffers = {}, {}
    local i = 1

    for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[b].buflisted then
            local ch = pick_alphabet:sub(i, i)
            if ch == "" then break end
            pick_map[b], pick_buffers[i] = ch, b
            i = i + 1
        end
    end
end

local function pick_action(on_select)
    refresh_pick_data()
    pick_mode = true
    vim.cmd("redrawtabline")

    local ok, key = pcall(vim.fn.getcharstr)

    pick_mode = false
    vim.cmd("redrawtabline")

    if not ok then return end

    local n = pick_alphabet:find(key, 1, true)
    if n and pick_buffers[n] then
        on_select(pick_buffers[n])
    end
end

function M.setup(tabline)
    tabline.setup({
        show_icons = true,
        format = function(buf_id, label)
            local prefix = ""
            if pick_mode and pick_map[buf_id] then
                prefix = pick_map[buf_id]
            end
            local suffix = vim.bo[buf_id].modified and " " or ""
            return " " .. prefix .. tabline.default_format(buf_id, label) .. suffix .. " "
        end,
        tabpage_section = "right",
    })

    vim.keymap.set("n", "gb", function()
        pick_action(function(buf)
            vim.api.nvim_win_set_buf(0, buf)
        end)
    end, { desc = "Pick Buffer" })

    vim.keymap.set("n", "gD", function()
        pick_action(function(buf)
            Snacks.bufdelete({ buf = buf })
        end)
    end, { desc = "Pick Buffer Close" })
end

return M
