


vim.cmd[[
	" let g:coq_settings = {  }
	let g:coq_settings = {
		\ "keymap.recommended": v:false,
		\ "keymap.jump_to_mark": "<nop>",
		\ "keymap.pre_select": v:true,
		\ "display.ghost_text.highlight_group": "Keyword",
		\ "display.pum.source_context": ["「", "」"],
		\ "display.pum.kind_context": ["「 ", " 」"],
		\ "display.ghost_text.enabled": v:false,
		\ "display.pum.fast_close": v:false,
	\ }
	ino <silent><expr> <tab>    pumvisible() ? (complete_info().selected == -1 ? "\<C-n>\<C-y>" : "\<C-y>") : "\<tab>"
	" scrollbar
	highlight PmenuThumb guibg=#e86671 gui=bold

	" menu selection when you use arrows
	hi PmenuSel guibg=#e86671

]]

-- doesnt work


-- function HandleTab()
-- 	-- open but not selected
-- 	if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected == -1 then
-- 		vim.cmd[[call feedkeys("\\<c-n>\\<c-y>")]]
-- 	else if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
-- 		vim.cmd[[call feedkeys("\\<c-y>")]]
-- 	else
-- 		vim.cmd[[call feedkeys("    ")]]
-- 	end
-- end

-- vim.api.nvim_set_keymap("i", "<tab>", "<c-o>:lua HandleTab()<CR>", { noremap = true, silent = true})


-- vim.g.coq_settings = {
-- 	["keymap.jump_to_mark"] = "v:false",
-- 	["keymap.pre_select"] = "v:false"
-- }

