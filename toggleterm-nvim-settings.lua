require("toggleterm").setup {
    -- size can be a number or function which is passed the current terminal
    -- function(term)
    --
    --   if term.direction == "horizontal" then
    --     return 40
    --   elseif term.direction == "vertical" then
    --     return 40
    --   end
    -- e,
    size = 80,
    -- open_mapping = [["<c-\>"]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = { "none", "fzf" },
    shade_terminals = false,
    -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = "vertical", -- | 'horizontal' | 'window' | 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "single", -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        width = 200,
        height = 50,
        winblend = 3,
        highlights = { border = "Normal", background = "Normal" }
    }
}

vim.api.nvim_set_keymap("n", "<C-t>", ":ToggleTerm<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-t>", "<C-o>:ToggleTerm<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-t>", "<esc>:ToggleTerm<CR>",
                        { noremap = true, silent = true })

-- vim.g.toggleterm_terminal_mapping = "<C-t>"

-- vim.cmd[[
-- " set
-- " let g:toggleterm_terminal_mapping = '<C-t>'
-- " or manually...
-- " autocmd TermEnter term://*toggleterm#*
--       \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
--
-- " By applying the mappings this way you can pass a count to your
-- " mapping to open a specific window.
-- " For example: 2<C-t> will open terminal 2
-- " nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
-- " inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
--
-- ]]

local cmd = vim.cmd

function TermExecWrapper(command) cmd("TermExec cmd='" .. command .. "'") end


function StringSplit(string, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(string, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end


function GetDirname(path)
    local splitted = StringSplit(path, "/")
    local dirname = "/"
    for i = 1, #splitted - 1 do dirname = dirname .. splitted[i] .. "/" end
    return dirname
end


-- run current file
function RunCode()
    local filename = vim.fn.bufname("%")
    local filetype = vim.bo.filetype
    if filetype == "python" then
        -- strfind is nil
        -- if strfind(filename, "manage.py") then
        -- cmd("TermExec cmd='python3 " .. filename ..
        -- " runserver 9000'")
        -- else
        cmd("TermExec cmd='python3 " .. filename .. "'")
        -- end
        -- vim.cmd("TermExec cmd='python3 " .. vim.fn.expand("%:p") .. "'")
        --
    elseif filetype == "javascript" then
        cmd("TermExec cmd='node " .. filename .. "'")

    elseif filetype == "go" then
        TermExecWrapper("go run " .. filename)

    elseif filetype == "cpp" then
        local name = StringSplit(filename, ".")[1]
        TermExecWrapper("g++ " .. filename .. " -o " .. name .. " && ./" .. name)

    elseif filetype == "c" then
        local name = StringSplit(filename, ".")[1]
        TermExecWrapper("gcc " .. filename .. " -o " .. name .. " && ./" .. name)

    elseif filetype == "html" then
        TermExecWrapper("live-server " .. filename)

    elseif filetype == "lua" then
        TermExecWrapper("lua " .. filename)

    elseif filetype == "markdown" then
        TermExecWrapper("/usr/bin/liveglow " .. filename)
    end

end


vim.api.nvim_set_keymap("n", "<c-a-n>", ":lua RunCode()<cr>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-a-n>", "<c-o>:lua RunCode()<cr>",
                        { noremap = true, silent = true })

-- run tests
function RunTestCases()
    local filename = vim.fn.bufname("%")
    local filetype = vim.bo.filetype

    if filetype == "python" then
        TermExecWrapper("pytest -vv " .. filename)
    elseif filetype == "javascript" then
        TermExecWrapper("npm run test")
    end

end


-- vim.api.nvim_set_keymap("n", "<c-a-m>", ":lua RunCode()<cr>",
--                         { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<c-o><c-a-m>", ":lua RunCode()<cr>",
--                         { noremap = true, silent = true })
