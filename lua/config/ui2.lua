local ok, ui2 = pcall(require, "vim._core.ui2")
if not ok then
    return
end

ui2.enable({
    enable = true,
    msg = {
        targets = {
            default = "msg",
            emsg = "msg",
            echoerr = "msg",
            lua_error = "msg",
            rpc_error = "msg",
            shell_err = "msg",

            undo = "msg",
            yank = "msg",
            [""] = "msg",
            empty = "msg",

            echo = "msg",
            echomsg = "msg",
            lua_print = "msg",
            progress = "msg",

            shell_cmd = "pager",
            shell_out = "pager",
            verbose = "pager",
            list_cmd = "pager",
        },
        msg = { height = 0.4, timeout = 3000 },
        pager = { height = 0.5 },
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "msg",
    callback = function(args)
        local win = ui2.wins and ui2.wins.msg
        if win and vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, { focusable = true })
            vim.api.nvim_set_option_value(
                "winhighlight",
                "Normal:NormalFloat,Search:,CurSearch:,IncSearch:,FloatBorder:FloatBorder,FloatTitle:NormalFloat",
                { scope = "local", win = win }
            )
        end

        local function close_popup()
            local w = ui2.wins and ui2.wins.msg
            if w and vim.api.nvim_win_is_valid(w) then
                pcall(vim.api.nvim_win_close, w, true)
            end
        end

        vim.keymap.set("n", "q", close_popup, { buffer = args.buf, silent = true, desc = "Cerrar popup" })
        vim.keymap.set("n", "<Esc>", close_popup, { buffer = args.buf, silent = true, desc = "Cerrar popup" })
    end,
})

local ok_msgs, msgs = pcall(require, "vim._core.ui2.messages")
if ok_msgs and msgs.set_pos then
    local orig_set_pos = msgs.set_pos

    local function has_active_msg()
        return next(msgs.msg.ids) ~= nil
    end

    msgs.set_pos = function(tgt)
        orig_set_pos(tgt)

        -- Only reposition when a message is (or may be) visible in the msg window.
        local is_msg = tgt == "msg"
        if not (is_msg or (tgt == nil and has_active_msg())) then
            return
        end

        local win = ui2.wins and ui2.wins.msg
        if not (win and vim.api.nvim_win_is_valid(win)) then
            return
        end

        if is_msg and vim.api.nvim_win_get_config(win).hide then
            return -- Nothing visible to position.
        end

        local buf = vim.api.nvim_win_get_buf(win)
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local text = table.concat(lines, " ")

        local is_error = text:match("E%d+:") or text:match("[Ee]rror") or text:match("traceback")
        local border_hl = is_error and "DiagnosticFloatingError" or "FloatBorder"

        pcall(vim.api.nvim_win_set_config, win, {
            relative = "editor",
            anchor = "NE",
            row = 1,
            col = vim.o.columns - 1,
            border = "rounded",
            title = is_error and " Error " or " Notificación ",
            title_pos = "center",
        })

        pcall(vim.api.nvim_set_option_value, "winhighlight",
            "Normal:NormalFloat,Search:,CurSearch:,IncSearch:,FloatBorder:" ..
            border_hl .. ",FloatTitle:" .. (is_error and "DiagnosticError" or "Directory"),
            { scope = "local", win = win })
    end
end
