require("neoclip").setup({
    history = 1000,
    filter = nil,
    preview = true,
    default_register = "\"",
    content_spec_column = true,
    on_paste = {
        set_reg = false,
    },
    keys = {
        i = {
            select = "<cr>",
            paste = "<c-p>",
            paste_behind = "<c-k>",
        },
        n = {
            select = "<cr>",
            paste = "p",
            paste_behind = "P",
        },
    },
})
