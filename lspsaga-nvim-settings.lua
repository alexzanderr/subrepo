
-- lspsaga-nvim
--
-- plugin url
-- https://github.com/glepnir/lspsaga.nvim


-- dont map this to just simple 'd'
-- because it will detect default key from vim and it will
-- have a short delay of 2 seconds


local noremap_silent = {
	noremap = true,
	silent = true
}

-- nnoremap function
local nnoremap = function(trigger_key, command)
	vim.api.nvim_set_keymap('n', trigger_key, command, noremap_silent)
end


-- vnoremap function
local inoremap = function(trigger_key, command)
	vim.api.nvim_set_keymap('i', trigger_key, command, noremap_silent)
end



local lspsaga_module = require 'lspsaga'


--
-- by installing release 0.5 diagnostics icons were fixed and now they appear with the proper colors
-- and also diagnostics colors are fixed, because of the version
lspsaga_module.init_lsp_saga {
	use_saga_diagnostic_sign = true,
	error_sign = '',
	warn_sign = '',
	hint_sign = '',
	infor_sign = '',
	dianostic_header_icon = '   ',
	code_action_icon = ' ',
	-- https://www.reddit.com/r/neovim/comments/mrv0a5/how_to_get_rid_of_this_bulb/
	code_action_prompt = { enable = false, },
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
	rename_prompt_prefix = 'rename ➤',
	rename_action_keys = {
	  quit = '<esc>', exec = '<CR>'  -- quit can be a table
	}
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}
}


function F2_keybinding()
	local ft = vim.bo.filetype
	if ft == "NvimTree" then
		-- require'nvim-tree'.on_keypress('full_rename')
		require'nvim-tree'.on_keypress('rename')
		-- print("rename not available for NvimTree")
	-- elseif not ft == "Outline" and not ft == "toggleterm" then
	else
		vim.cmd("Lspsaga rename")
	end
end


nnoremap("<F2>", ":lua F2_keybinding()<CR>")
inoremap("<F2>", "<c-o>:lua F2_keybinding()<CR>")
-- nnoremap("<A-d>", ":Lspsaga preview_definition<CR>")
-- nnoremap("<A-d>", ":Lspsaga hover_doc<CR>")
-- nnoremap("<A-r>", ":Lspsaga lsp_finder<CR>")
-- nnoremap("<A-e>", ":Lspsaga diagnostic_jump_next<CR>")
-- nnoremap("<C-e>", ":Lspsaga diagnostic_jump_prev<CR>")


