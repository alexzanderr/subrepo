local sidebar = require("sidebar-nvim")
local opts = {
    open = false,
    disable_default_keybindings = true,
    side = "left",
    initial_width = 40,
    update_interval = 2000,
    sections = {
        "datetime",
        "git-status",
        "lsp-diagnostics",
        require("dap-sidebar-nvim.breakpoints")
    },
    section_separator = "─────",
    bindings = {
        ["q"] = function() require("sidebar-nvim").close() end
,

        ["<C-q>"] = function() require("sidebar-nvim").close() end


    },
    datetime = {
        -- format = "%d.%m.%Y-%H:%M:%S",
        clocks = { name = "andrew's clock" }
    }
}
sidebar.setup(opts)
