-- the primeagen's harpoon
--
-- plugin url
-- https://github.com/ThePrimeagen/harpoon
--
--
require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
    },
    -- ... your other configs ...
})

-- https://vi.stackexchange.com/questions/19358/cannot-map-ctrl-number-except-6-or
--
-- Ctrl-1 is not detected
-- Ctrl-2 is Ctrl-@ (hex 0x00)
-- Ctrl-3 is Ctrl-[ aka ESC
-- Ctrl-4 is Ctrl-\
-- Ctrl-5 is Ctrl-]
-- Ctrl-6 is Ctrl-^
-- Ctrl-7 is Ctrl-_
-- Ctrl-8 is Ctrl-? aka Delete used as Backspace
-- Ctrl-9 is not detected
-- Ctrl-0 is not detected


-- ctrl + m is <CR>
-- not its mappend to Alt+M
vim.api.nvim_set_keymap("n", "<a-m>",
                        ":lua require(\"harpoon.mark\").add_file()<cr>",
                        {
    noremap = true,
    silent = true,
})

vim.api.nvim_set_keymap("i", "<a-m>",
                        "<c-o>:lua require(\"harpoon.mark\").add_file()<cr>",
                        {
    noremap = true,
    silent = true,
})


vim.api.nvim_set_keymap("n", "<A-1>",
                        ":lua require(\"harpoon.ui\").nav_file(1)<cr>",
                        {
    noremap = true,
    silent = true,
})
vim.api.nvim_set_keymap("n", "<A-2>",
                        ":lua require(\"harpoon.ui\").nav_file(2)<cr>",
                        {
    noremap = true,
    silent = true,
})
vim.api.nvim_set_keymap("n", "<A-3>",
                        ":lua require(\"harpoon.ui\").nav_file(3)<cr>",
                        {
    noremap = true,
    silent = true,
})
vim.api.nvim_set_keymap("n", "<A-4>",
                        ":lua require(\"harpoon.ui\").nav_file(4)<cr>",
                        {
    noremap = true,
    silent = true,
})

vim.api.nvim_set_keymap("i", "<A-1>",
                        "<c-o>:lua require(\"harpoon.ui\").nav_file(1)<cr>",
                        {
    noremap = true,
    silent = true,
})
vim.api.nvim_set_keymap("i", "<A-2>",
                        "<c-o>:lua require(\"harpoon.ui\").nav_file(2)<cr>",
                        {
    noremap = true,
    silent = true,
})
vim.api.nvim_set_keymap("i", "<A-3>",
                        "<c-o>:lua require(\"harpoon.ui\").nav_file(3)<cr>",
                        {
    noremap = true,
    silent = true,
})
vim.api.nvim_set_keymap("i", "<A-4>",
                        "<c-o>:lua require(\"harpoon.ui\").nav_file(4)<cr>",
                        {
    noremap = true,
    silent = true,
})
