

vim.g.cheat_default_window_layout = 'vertical_split'
vim.api.nvim_set_keymap("n", "<a-p>", ":CheatWithoutComments<CR>", {
	noremap = true,
	silent = true
})
vim.api.nvim_set_keymap("i", "<a-p>", "<c-o>:CheatWithoutComments<CR>", {
	noremap = true,
	silent = true
})

