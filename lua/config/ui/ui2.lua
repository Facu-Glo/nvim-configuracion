local ok, ui2 = pcall(require, "vim._core.ui2")
if not ok then
    return
end

ui2.enable({
    enable = true,
    msg = {
        targets = 'cmd',
        dialog = {
            height = 0.5,
        },
        msg = {
            height = 0.2,
        },
        pager = {
            height = 0.5,
        },
    },
})
