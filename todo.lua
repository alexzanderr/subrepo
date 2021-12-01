

local g = {}

g.todos = {
	"map gd (go to definition builtin from vim when :lua vim.lsp.buf.goto_definition() fails because no LSP in background",
	"when using nvim -u NONE, neovim is still sourcing all plugins from site/pack/packer/start/*, because i could use telescope from nvim without any plugin",
	"cannot go back where the mouse was, because the mouse is not mapping location as the vim's cursor is mapping to go back and forward",
	"packer is not installed in root, thats why neovim with sudo doesnt work, even if have runtime path updated ",
	"telescope find text in file (Alt-f) are o problema cu jsonc files si acum este foarte slow si nu stiu de ce",
	"when using formatter please take whats from the buffer even if the buffer its not saved",
	"check this https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc and this https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer; about rust analyzer",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"add image preview with ueberzurg when encounting image files in telescope find_files or live_grep",
	"add word count (https://vim.fandom.com/wiki/Word_count) to markdown or text file; in statusline",
	"when adding new file in project the lsp doesnt recognize it, until lsp restart, you can fix this by reloading lsp after Alt-a (creation of new file)",
	"telescope sort live_grep results in ascending order depending on the line number",
	"make a better source system when you press <F5>, i mean source every individual file and reload all pluggins inside neovim",
	"snippets, i dont have custom snippets",
	"debugger (very hard)",
	"debugger for django",
}

g.print_todo_list = function()
	print("todo list for neovim lua")
	for index, todo in pairs(g.todos) do
	print(index .. " - " .. todo)
	end
end




return g
