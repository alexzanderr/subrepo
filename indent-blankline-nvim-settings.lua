


-- indent-blankline-nvim
--
-- plugin url
-- https://github.com/lukas-reineke/indent-blankline.nvim
--
--
--
--
local indentline_char = '▏'
-- local indentline_char = "⎢"
-- custom modification to this plugin
--
--
-- in the file indent-blankline.nvim/plugin/indent_blankline.vim; line 32 -> 37
-- autocmd InsertEnter,FileChangedShellPost,InsertLeave,BufWinEnter,Filetype,BufWrite * IndentBlanklineRefresh


require("indent_blankline").setup {
    char = indentline_char,
	-- no file solved with NvimTree
    buftype_exclude = {"terminal", "NvimTree", "toggleterm", "Outline", "tree", "filetree", "nofile", "dashboard"},

	-- colors a line with a specific color the speicify your current location (if true)
	show_current_context = false,
	-- this beautiful option is setting an autocmd on event CursorMoved and CursorMovedI which
	-- makes performance very bad
	-- the autocmds are located in
	-- indent-blankline.nvim/lua/indent_blankline/init.lua; line 136 -> 143
	-- and
	-- indent-blankline.nvim/plugin/indent_blankline.vim; line 32 -> 37
	context_patterns = {
		"def",
		"class",
		"return",
		"function",
		"method",
		"^if",
		"^while",
		"jsx_element",
		"^for",
		"string",
		"docstring",
		"comment",
		"self",
		"try",
		"except",
		"finally"
		-- ... and you can add more
	},
	show_trailing_blankline_indent = false,
	use_treesitter = false
}

vim.cmd[[highlight IndentBlanklineContextChar guifg=#f73e3e gui=nocombine]]
-- vim.cmd[[highlight IndentBlanklineContextChar guifg=#e3d64d gui=nocombine]]

vim.g.indent_blankline_filetype_exclude = {"dashboard"}




