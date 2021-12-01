--
-- core.lua
--
local module = {}

module.esc = "<esc>"
module.co = "<C-o>"
module.cr = "<CR>"

-- some documentation for this function
-- https://www.lua.org/pil/5.3.html
-- nnoremap function
module.nnoremap = function(options)
    -- trigger key
    local key = options[1] or options.key
    -- command
    local command = options[2] or options.command

    -- noremap is true by default
    local noremap = options.noremap
    if noremap == nil then noremap = true end

    -- silent is true by default
    local silent = options.silent
    if silent == nil then silent = true end

    -- expr is false by default
    local expr = options.expr
    if expr == nil then expr = false end

    vim.api.nvim_set_keymap("n", key, command,
                            { noremap = noremap, silent = silent, expr = expr })
end


-- inoremap function
module.inoremap = function(options)
    -- trigger key
    local key = options[1] or options.key
    -- command
    local command = options[2] or options.command
    -- noremap is true by default
    local noremap = options.noremap or true
    -- silent is true by default
    local silent = options.silent or true
    -- expr is false by default
    local expr = options.expr or false

    vim.api.nvim_set_keymap("i", key, command,
                            { noremap = noremap, silent = silent, expr = expr })
end


-- vnoremap function (visual mode)
module.vnoremap = function(options)
    -- trigger key
    local key = options[1] or options.key
    -- command
    local command = options[2] or options.command
    -- noremap is true by default
    local noremap = options.noremap or true
    -- silent is true by default
    local silent = options.silent or true
    -- expr is false by default
    local expr = options.expr or false

    vim.api.nvim_set_keymap("v", key, command,
                            { noremap = noremap, silent = silent, expr = expr })

end


-- tnoremap function (terminal mode)
module.tnoremap = function(options)
    -- trigger key
    local key = options[1] or options.key
    -- command
    local command = options[2] or options.command
    -- noremap is true by default
    local noremap = options.noremap or true
    -- silent is true by default
    local silent = options.silent or true
    -- expr is false by default
    local expr = options.expr or false

    vim.api.nvim_set_keymap("t", key, command,
                            { noremap = noremap, silent = silent, expr = expr })
end


-- cnoremap function (terminal mode)
module.cnoremap = function(options)
    -- trigger key
    local key = options[1] or options.key
    -- command
    local command = options[2] or options.command
    -- noremap is true by default
    local noremap = options.noremap or true
    -- silent is true by default
    local silent = options.silent or true
    -- expr is false by default
    local expr = options.expr or false

    vim.api.nvim_set_keymap("c", key, command,
                            { noremap = noremap, silent = silent, expr = expr })
end


module.get_current_buffer_filetype = function()
    return vim.api.nvim_buf_get_option(0, "filetype")
end


module.get_active_lsp_clients =
    function() return vim.lsp.get_active_clients() end


module.print_red = function(string)
    vim.cmd("echohl Red | echon '" .. string .. "' | echohl None")
end


-- this returns the buffer number coresponding to the filetype
module.get_buffer_number_by_filetype = function(filetype)
    local buffers = vim.fn.getbufinfo()
    for index, _ in pairs(buffers) do
        local bname = buffers[index]["name"]
        if string.find(bname, filetype) then
            return buffers[index]["bufnr"]
        end
    end
    return -1
end


-- this is from astronauta.nvim
module.lua_nnoremap = vim.keymap.nnoremap
module.lua_inoremap = vim.keymap.inoremap
module.lua_vnoremap = vim.keymap.vnoremap
module.lua_tnoremap = vim.keymap.tnoremap
module.lua_cnoremap = vim.keymap.cnoremap


-- get all the lines of the current buffer
module.get_lines_of_current_buffer = function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, vim.fn.line("$"), true)
	local file = ""
	for key, value in pairs(lines) do
		-- if value == "" then
		-- 	file = file .. "\n"
		-- end
		file = file .. value .. "\n"
	end
	-- print(file)
	-- not working
	os.execute("echo '" .. file .. "' > /tmp/file.txt &")
end

return module
