-- vim-visual-multi
--
-- plugin url
-- https://github.com/mg979/vim-visual-multi
--
--
-- https://github.com/nanotee/nvim-lua-guide#calling-vimscript-functions

local core = require("core")
local nnoremap = core.nnoremap
local inoremap = core.inoremap
local co = core.co

local global_variable = vim.g

-- " https://github.com/mg979/vim-visual-multi/blob/master/autoload/vm/maps/all.vim

global_variable.VM_mouse_mappings = 1


-- these only work if they are called from vim script .. bleah
vim.cmd[[
	let g:VM_maps = {}
	" new cursor down
	let g:VM_maps["Add Cursor Down"] = '<C-S-Down>'
	" new cursor up
	let g:VM_maps["Add Cursor Up"] = '<C-S-Up>'
	" new cursor at cursor location
	let g:VM_maps["Add Cursor At Pos"] = '<space><CR>'


	let g:VM_maps["Undo"] = '<C-z>'
	let g:VM_maps["Redo"] = '<C-r>'

	" this helped me get rid of add cursor when
	" shift left or shift right
	" because i have a mapping to indent
	let g:VM_default_mappings = 0

]]

-- local maps = vim_function["vm#maps#all#buffer"]()
-- maps["Select l"] = ""
-- maps["Select h"] = ""

-- local maps = vim.cmd("call vm#maps#all#buffer()")

-- global_variable.VM_maps = {}
-- -- new cursor vertically up
-- global_variable.VM_maps["Add Cursor Down"] = "<S-Down>"
-- -- new cursor vertically down
-- global_variable.VM_maps["Add Cursor Up"] = "<S-Up>"
-- -- new cursor at cursor location
-- global_variable.VM_maps["Add Cursor At Pos"] = "<space><CR>"
-- -- undo
-- global_variable.VM_maps["Undo"] = "u"
-- -- redo
-- global_variable.VM_maps["Redo"] = "<C-r>"

-- " require
-- " let g:VM_maps["Visual All"] = '<C-D>'
-- " let g:VM_maps["Select All"] = '<C-D>'
--
-- " ca poti sa dai cancel la S-Left, acel selection
-- " ~/.config/nvim/plugged/vim-visual-multi/autoload/vm/maps/all.vim
-- " line 60
-- " si comentezi asta
-- " let maps["Select l"][0]              = '<S-Right>'
-- " si pui asa
-- " let maps["Select l"][0]              = ''
-- " si pui asa
-- " let maps["Select h"][0]              = '<S-Left>'
-- " let maps["Select h"][0]              = ''

-- nmap   <C-LeftMouse>         <Plug>(VM-Mouse-Word)

-- add cursor with control + left click
nnoremap{"<C-LeftMouse>", ":call vm#commands#add_cursor_at_pos(0)<cr>"}


-- select all occurrences with control + D, just like vs code
nnoremap{"<C-d>", ":call vm#commands#find_all(0, 1)<cr>"}
inoremap{"<C-d>", ":call vm#commands#find_all(0, 1)<cr>"}

-- function ControlD()
-- 	local ft = vim.bo.filetype
-- 	if ft == "TelescopePrompt" then
-- 		print("telescope")
-- 		vim.cmd("normal <c-d>")
-- 	end
-- 	print(vim.fn.bufname("%"))
-- end

-- inoremap{"<c-down>", co .. ":lua ControlD()<CR>"}
-- nnoremap{"<c-down>", ":lua ControlD()<CR>"}
