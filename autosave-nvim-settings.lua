
-- auto save plugin
--
-- https://github.com/Pocco81/AutoSave.nvim
--
local autosave = require("autosave")

autosave.hook_after_off = function() print("autosave toggled off!") end


autosave.hook_after_saving = function() end


autosave.setup({
    enabled = true,
    execution_message = "AutoSave: " .. vim.fn.bufname("%") .. " saved at " ..
        vim.fn.strftime("%H:%M:%S"),
    events = { "InsertLeave", "TextChanged", "TextChangedI" },
    conditions = {
        exists = true,
        filename_is_not = {},
        filetype_is_not = {},
        modifiable = true
    },
    write_all_buffers = true,
    on_off_commands = true,
    clean_command_line_interval = 1000,

    -- after 2 seconds have passed, after events:
    -- (InsertLeave, TextChanged)
    -- autosave is triggered
    debounce_delay = 4444
})
