vim.cmd [[
	" Link CursorLine into RnvimrNormal highlight in the Floating window
	highlight link RnvimrNormal CursorLine
]]

-- " Fullscreen for initial layout
vim.g.rnvimr_layout = {
    ["relative"] = "editor",
    ["width"] = vim.fn.winwidth("%"),
    ["height"] = vim.fn.winheight("%"),
    ["col"] = 0,
    ["row"] = 1,
    ["style"] = "minimal",
}
--
--
--
-- -- " this is responsible for ranger's position, coordinates, width, height inside nvim
-- vim.g.rnvimr_layout = {
--     ["relative"] = "editor",
--     ["width"] = vim.fn.float2nr(vim.fn.round(0.98 * vim.fn.winwidth("%"))),
--     ["height"] = vim.fn.float2nr(vim.fn.round(0.88 * vim.fn.winheight("%"))),
--     ["col"] = vim.fn.float2nr(vim.fn.round(0.01 * vim.fn.winwidth("%"))),
--     ["row"] = vim.fn.float2nr(vim.fn.round(0.05 * vim.fn.winheight("%"))),
--     ["style"] = "minimal",
-- }

-- " Add views for Ranger to adapt the size of floating window
vim.g.rnvimr_ranger_views = {
    {
        ["minwidth"] = 90,
        ["ratio"] = {},
    },
    {
        ["minwidth"] = 90,
        ["maxwidth"] = 89,
        ["ratio"] = {
            1,
            1,
        },
    },
    {
        ["maxwidth"] = 90,
        ["ratio"] = {
            1,
        },
    },
}

-- " Map Rnvimr action
vim.g.rnvimr_action = {
    ["<CR>"] = "NvimEdit tabedit",
    ["<C-x>"] = "NvimEdit split",
    ["<C-v>"] = "NvimEdit vsplit",
    ["gw"] = "JumpNvimCwd",
    ["yw"] = "EmitRangerCwd",
}

-- " Make Ranger replace netrw and be the file explorer
vim.g.rnvimr_ex_enable = 0
-- " Make Ranger to be hidden after picking a file
vim.g.rnvimr_enable_picker = 1
-- " Disable a border for floating window
vim.g.rnvimr_draw_border = 0
-- " Hide the files included in gitignore
vim.g.rnvimr_hide_gitignore = 0
-- " Change the border's color
-- " let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}
-- " Make Neovim wipe the buffers corresponding to the files deleted by Ranger
vim.g.rnvimr_enable_bw = 1
-- " Add a shadow window, value is equal to 100 will disable shadow
-- " let g:rnvimr_shadow_winblend = 70

vim.api.nvim_set_keymap("n", "<leader>r", ":RnvimrToggle<CR>", {
    noremap = true,
    silent = true,
})
