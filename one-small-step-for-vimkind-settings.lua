--
--
--
--
local dap = require "dap"
dap.configurations.lua = {
    {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance"
        --         host = function()
        --             local value = vim.fn.input("Host [127.0.0.1]: ")
        --             if value ~= "" then return value end
        --             return "127.0.0.1"
        --         end
        -- ,
        --         port = function()
        --             local val = tonumber(vim.fn.input("Port: "))
        --             assert(val, "Please provide a port number")
        --             return val
        --         end

    }
}

dap.adapters.nlua = function(callback, config)
    callback({
        type = "server",
        host = config.host or "127.0.0.1",
        port = config.port or 8082
    })
end





vim.api.nvim_set_keymap('n', '<F8>', [[:lua require"dap".toggle_breakpoint()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F9>', [[:lua require"dap".continue()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F10>', [[:lua require"dap".step_over()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<S-F10>', [[:lua require"dap".step_into()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F36>', [[:lua require"dap.ui.variables".hover()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F5>', [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F6>', [[:lua require"osv".run_this()<CR>]], { noremap = true })
