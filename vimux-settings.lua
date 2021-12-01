
local core = require("core")
local nnoremap = core.nnoremap
local inoremap = core.inoremap
local co = core.co

vim.g.VimuxHeight = "50"
vim.g.VimuxOrientation = "h"
vim.g.VimuxOpenExtraArgs = "-b"
vim.g.VimuxUseNearest = 0


vim.g.VimuxCloseOnExit = 1
vim.g.VimuxPromptString = "enter command for tmux splitted pane: "
vim.g.VimuxRunnerName = "vscode-code-runner"


function VimuxRunCommandLua(command)
	vim.cmd("call VimuxRunCommand(\"" .. command .. "\")")
end

function StringSplit(string, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(string, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

-- just like vs code code runner
function TmuxRunCode(below)
	print(below)
	if below then
		vim.g.VimuxOrientation = "v"
		vim.g.VimuxOpenExtraArgs = ""
	end

	if vim.bo.modified then
		vim.cmd("w!")
	end

	local ft = vim.bo.filetype
	local bname = vim.fn.bufname("%")
	local filename = StringSplit(ft, ".")[1]

	if ft == "python" then
		if string.find(bname, "manage.py") then
			VimuxRunCommandLua("python3 manage.py runserver 9000")
		else
			VimuxRunCommandLua("python3 " .. bname)
		end

	elseif ft == "javascript" then
		VimuxRunCommandLua("node " .. bname)

	elseif ft == "go" then
		VimuxRunCommandLua("go run " .. bname)

	elseif ft == "cpp" then
		VimuxRunCommandLua("g++ " .. bname .. " -o " .. filename .. " && ./" ..
		filename)

	elseif ft == "c" then
		VimuxRunCommandLua("gcc " .. bname .. " -o " .. filename .. " && ./" .. filename)

	elseif ft == "html" then
		VimuxRunCommandLua("live-server " .. bname)

	elseif ft == "markdown" then
		VimuxRunCommandLua("/usr/bin/liveglow " .. bname)
	end

	vim.g.VimuxHeight = "20"
	vim.g.VimuxOrientation = "h"
	vim.g.VimuxOpenExtraArgs = "-b"
end

vim.api.nvim_set_keymap("n", "<C-A-m>", ":lua TmuxRunCode(false)<CR>", {
	noremap = true,
	silent = true
})
vim.api.nvim_set_keymap("i", "<C-A-m>", "<c-o>:lua TmuxRunCode(false)<CR>", {
	noremap = true,
	silent = true
})

vim.api.nvim_set_keymap("n", "<c-a-b>", ":lua TmuxRunCode(true)<CR>", {
	noremap = true,
	silent = true
})
vim.api.nvim_set_keymap("i", "<c-a-b>", "<c-o>:lua TmuxRunCode(true)<CR>", {
	noremap = true,
	silent = true
})


function TmuxRunTestCases()
	local ft = vim.bo.filetype
	local bufname = vim.fn.bufname("%")
	if ft == "python" then
		VimuxRunCommandLua("pytest -vv " .. bufname)
	elseif ft == "javascript" then
        VimuxRunCommandLua("npm run test")
	else
		print("wrong filetype")
	end
end

nnoremap{ "<c-a-k>", ":lua TmuxRunTestCases()<CR>" }
inoremap{ "<c-a-k>", co .. ":lua TmuxRunTestCases()<CR>" }
