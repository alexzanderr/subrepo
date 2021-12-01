--
--
-- keybindings.lua
--
-- ~/.config/nvim/init.lua.d/lua/keybindings.lua
local noremap_silent = { noremap = true, silent = true }

-- because this is single threadaed and yhoutbue uses all the threads, also the neovim thread so thats why neovim goes slower when youtube is running with a reasouce eater video

local core = require("core")
local nnoremap = core.nnoremap
local inoremap = core.inoremap
local vnoremap = core.vnoremap
local tnoremap = core.tnoremap
-- local cnoremap = core.cnoremap

local lua_nnoremap = core.lua_nnoremap
local lua_inoremap = core.lua_inoremap
local lua_vnoremap = core.lua_vnoremap

local map = vim.api.nvim_set_keymap
local co = core.co
local esc = core.esc

-- disable space in normal mode
nnoremap { "<Space>", "<NOP>" }
vim.g.mapleader = " "

-- disable f1
nnoremap { "<F1>", "<nop>" }
inoremap { "<F1>", "<nop>" }

-- save current buffer
function SaveCurrentBuffer()
    if vim.bo.modifiable == true then
        vim.cmd("w!")
    else
        print("buffer is not modifiable")
    end
end


nnoremap { "<C-s>", ":lua SaveCurrentBuffer()<CR>" }
inoremap { "<C-s>", co .. ":lua SaveCurrentBuffer()<CR>" }
vnoremap { "<C-s>", esc .. ":lua SaveCurrentBuffer()<CR>" }

-- quit neovim
function QuitBuffer()
    -- SaveCurrentBuffer()
    vim.cmd("q!")

    -- TODO
    -- print buffer name and file type when closing
    -- print("buffer closed")
end


function Quit()
    local buffers = vim.fn.getbufinfo()
    local total_opened_buffers = vim.fn.bufnr("$")
    local total_opened_windows = vim.fn.winnr("$")

    local nvim_tree_buffer_active = false
    local toggle_term_buffer_active = false
    local outline_buffer_active = false

    for index, _ in pairs(buffers) do
        local bname = buffers[index]["name"]
        if string.find(bname, "NvimTree") then
            -- nvim tree is always opened
            -- even if its closed, its running in background
            nvim_tree_buffer_active = true

        elseif string.find(bname, "toggleterm") then
            toggle_term_buffer_active = true

        elseif string.find(bname, "Outline") or string.find(bname, "OUTLINE") then
            outline_buffer_active = true

        end
    end

    -- closing neovim if only current buffer is up and plus that nvim tree and toggle term
    if (nvim_tree_buffer_active and toggle_term_buffer_active and
        total_opened_buffers == 3 and total_opened_windows == 3) then
        vim.cmd("ToggleTermCloseAll")
    elseif nvim_tree_buffer_active and outline_buffer_active and
        total_opened_buffers == 3 and total_opened_windows == 3 then
        vim.cmd("SymbolsOutlineClose")
    elseif nvim_tree_buffer_active and outline_buffer_active and
        toggle_term_buffer_active and total_opened_buffers == 4 and
        total_opened_windows == 4 then
        vim.cmd("ToggleTermCloseAll")
        vim.cmd("SymbolsOutlineClose")
    end
    vim.cmd("q!")
end


map("n", "<C-q>", ":lua Quit()<CR>", noremap_silent)
map("i", "<C-q>", co .. ":lua Quit()<CR>", noremap_silent)
map("v", "<C-q>", esc .. ":lua Quit()<CR>", noremap_silent)
map("c", "<C-q>", ":lua Quit()<CR>", noremap_silent)

-- go back
nnoremap { "<A-Left>", "<c-o>" }
inoremap { "<A-Left>", co .. "<c-o>" }

-- go forward
nnoremap { "<A-Right>", "<c-i>" }
inoremap { "<A-Right>", co .. "<c-i>" }

-- nnoremap{"<C-c>", "<cmd> lua CopyCurrentLineToClipboard()<CR>"}
-- inoremap{"<C-c>", "<C-o><cmd> lua CopyCurrentLineToClipboard()<CR>"}

-- control + backspace to delete a word backwards
-- map("i", "<C-BS>", "<C-w>", noremap_silent)
-- map("i", "<C-h>", "<C-w>", noremap_silent)
--
--
-- this doesnt work
-- map("c", "<C-BS>", "<C-w>", noremap_silent)
-- map("c", "<C-h>", "<C-w>", noremap_silent)

-- this also mapped in command mode
-- i dont know how to simulate bang in lua vim api
inoremap { "<c-bs>", "<c-w>" }
inoremap { "<c-h>", "<c-w>" }

nnoremap { "<c-bs>", "i<c-w>" }
nnoremap { "<c-h>", "i<c-w>" }

vim.cmd [[
	map! <C-BS> <C-w>
	map! <C-h> <C-w>
]]

-- use colon instead of semi-colon for command-line mode
-- TODO fix this, make it not silent
-- nnoremap{trigger_key = ";", command = ":", noremap = true, silent = false, expr = false}
-- vnoremap{trigger_key = ";", command = "<esc>:", noremap = true, silent = false, expr = false}
nnoremap { ";", ":", silent = false }
vnoremap { ";", "<esc>:", silent = false }

-- undo
map("n", "<C-z>", "u", noremap_silent)
map("i", "<C-z>", "<C-o>u", noremap_silent)
map("v", "<C-z>", "<esc>u", noremap_silent)

-- redo
-- redo for normal mode is built-in
map("i", "<C-r>", "<C-o><C-r>", noremap_silent)
map("v", "<C-r>", "<esc><C-r>", noremap_silent)

-- control + x to delete the line
-- i to enter insert mode"
-- nnoremap <C-X> yyddi
-- you must use + for linux in order to put it in system clipboard"
-- https://stackoverflow.com/questions/3961859/how-to-copy-to-clipboard-in-vim"

map("n", "<C-x>", "\"+yydd", noremap_silent)

-- inoremap <C-X> <C-O>"+yydd
-- not working in neovim 0.5 nightly bin
map("i", "<C-x>", "<esc>\"+yyddi", noremap_silent)

-- with gv you can reselect the lost zone
map("v", "<C-x>", "\"+ygvd", noremap_silent)

-- block jump
-- up
nnoremap { "<C-A-up>", "{" }
inoremap { "<C-A-up>", "<C-o>{" }
vnoremap { "<C-A-up>", "{" }
-- down
nnoremap { "<C-A-down>", "}" }
inoremap { "<C-A-down>", "<C-o>}" }
vnoremap { "<C-A-down>", "}" }

-- copy current line to sys clipboard

-- local colored = require("ansi-colors")

function CopyCurrentLineToClipboard()
    -- https://til.hashrocket.com/posts/f9e3d24495-yank-full-line-without-new-line-character

    local line = vim.fn.getline(".")
    local ft = vim.bo.filetype
    if ft == "NvimTree" then
        require"nvim-tree".on_keypress("copy_absolute_path")
    else
        if line == "" then
            print("todo - copy the file path to clipboard")
        else
            -- copy just the text, not the empty space
            vim.cmd("normal ^\"+y$")
            print("line " .. vim.fn.line(".") .. " copied to clipboard")
        end
    end
    -- with this you will copy the entire line
    -- vim.cmd("execute 'normal \"+yy'")

end


nnoremap { "<C-c>", ":lua CopyCurrentLineToClipboard()<CR>" }
inoremap { "<C-c>", "<C-o>:lua CopyCurrentLineToClipboard()<CR>" }
-- nnoremap{"<C-c>", "\"+yy"}
-- inoremap{"<C-c>", "<C-o>\"+yy"}
vnoremap { "<C-c>", "\"+ygv" }
-- tnoremap{"<C-c>", "<C-o>\"+yy"}

-- paste from system clipboard
-- this is broken
-- it doesnt insert new line to paste properly
-- but running "+p along in cmd works
---- but running "+p along in cmd works
function PasteFromClipboard()
    vim.cmd("normal o<c-o><esc>")
    vim.cmd("normal \"+p")
    -- vim.cmd("normal o")
    print("pasted from clipboard")

end


-- control + v is already mapped by os
-- you cant override it in vim

-- vim.cmd[[
-- map! <C-v> <nop>
-- ]]

-- nnoremap{"<c-v>", "")}

-- note that here its a remap
-- vim.api.nvim_set_keymap("n", "<C-v>", ":lua PasteFromClipboard()<CR>", {
-- 	noremap = false,
-- 	silent = true,
-- })

-- nnoremap{"<C-p>", ":lua PasteFromClipboard()<CR>"}
nnoremap { "<A-v>", "o<c-o>\"+p<esc>" }
inoremap { "<A-v>", esc .. "o<c-o>\"+yp" }
vnoremap { "<A-v>", "\"+pgv" }

-- backspace in visual mode
vnoremap { "<bs>", "d" }

-- select all
nnoremap { "<C-a>", "ggVG" }
inoremap { "<C-a>", esc .. "ggVG" }
vnoremap { "<C-a>", esc .. "ggVG" }

-- highlight the entire paragraph
-- nnoremap{"<C-S-Up>", "<S-v>{"}
-- inoremap{"<C-S-Up>", "<ESC><S-v>{"}

-- nnoremap{"<C-S-Down>", "<S-v>}"}
-- inoremap{"<C-S-Down>", "<ESC><S-v>}"}

-- move line up with alt + up
-- with auto indent
-- nnoremap <silent> <A-Up> :move -2<CR>==
nnoremap { "<A-Up>", ":move -2<CR>" }
nnoremap { "<A-Down>", ":move +1<CR>" }

-- move line up in visual mode and keep selection
vnoremap { "<A-Up>", ":move '<-2<CR>gv=gv" }
-- move line down in visual mode and keep selection
vnoremap { "<A-Down>", ":move '>+1<CR>gv=gv" }

-- este ineficient ca sta sa ruleze de fiecare data
-- inoremap <silent> <A-Up> <C-O>:move -2<CR><C-o>==
-- move line down with alt + down
-- https://tech.saigonist.com/b/code/list-all-vim-script-events.html
inoremap {
    "<A-Up>",
    "<C-O>:move -2<CR><c-o>:lua require(\"cmp\").mapping.abort()<CR>"
}
inoremap {
    "<A-Down>",
    "<C-O>:move +1<CR><c-o>:lua require(\"cmp\").mapping.abort()<CR>"
}

-- this works well only in visual-line mode
-- duplicate the line up
-- nnoremap{"<C-S-A-Up>", "\"+yyP"}
-- inoremap{"<C-S-A-Up>", "<ESC>\"+yyPa"}
-- vnoremap{"<C-S-A-Up>", "\"+yPgv"}
nnoremap { "<C-S-A-Up>", "yyP" }
inoremap { "<C-S-A-Up>", "<ESC>yyPa" }
vnoremap { "<C-S-A-Up>", "yPgv" }

-- duplicate the line down
-- nnoremap{"<C-S-A-Down>", "\"+yyp"}
-- inoremap{"<C-S-A-Down>", "<ESC>\"+yyPi"}
-- vnoremap{"<C-S-A-Down>", "\"+yPgv"}
nnoremap { "<C-S-A-Down>", "yyp" }
inoremap { "<C-S-A-Down>", "<ESC>yyPi" }
vnoremap { "<C-S-A-Down>", "yPgv" }

-- vertical split pane to right
-- to left we cant because C-[ is actually ESC ..
nnoremap { "<C-]>", ":vsplit<CR>" }
inoremap { "<C-]>", co .. ":vsplit<CR>" }
vnoremap { "<C-]>", "<ESC>:vsplit<CR>v" }

-- insert tab space in visual mode
vnoremap { "<tab>", ">gv" }
vnoremap { "<S-tab>", "<gv" }

-- control right
-- if you are on the last word and the there is nothing after last word
-- with 'e' you will go at the end of the word
-- with 'w' you will go after the end of the word, on the next line
-- map("n", "<C-Right>", "e", noremap_silent)
-- navigate with control left/right arrow
-- normally vim jumps to the text space, i want to jump to the next word
nnoremap { "<C-Right>", "e" }
-- maybe will make performance worse ?
--
-- its a little bit slow but its working
-- if you dont like cursor flickering
-- please find a better way to go just at the end of the word
--
inoremap { "<C-Right>", co .. "e" .. co .. "<right>" }

nnoremap { "<C-Left>", "b" }
-- maybe will make performance worse ?
inoremap { "<C-Left>", co .. "b" }

-- indent/unindent with tab/shift-tab
nnoremap { "<C-S-Right>", ">>" }
nnoremap { "<C-S-Left>", "<<" }

inoremap { "<C-S-Left>", "<C-O><<" }
inoremap { "<C-S-Right>", "<C-O>>>" }

vnoremap { "<C-S-Left>", "<gv" }
vnoremap { "<C-S-Right>", ">gv" }

-- resize current buffer with keyboard
nnoremap { "`<right>", "4<C-W><" }
nnoremap { "`<left>", "4<C-W>>" }
nnoremap { "`<Up>", "4<C-W>-" }
nnoremap { "`<Down>", "4<C-W>+" }

-- select to end of the line from current cursor position
inoremap { "<S-End>", "<ESC>v<End>" }
nnoremap { "<S-End>", "v<End>" }

-- select to the beginnging of the line from current cusor position
inoremap { "<S-Home>", "<ESC>v<Home>" }
nnoremap { "<S-Home>", "v<Home>" }

-- enter in insert mode from visual
-- by default just i doesnt work
vnoremap { "i", "<S-i>" }

-- scroll with keyboard
nnoremap { "<C-up>", "<C-Y>" }
inoremap { "<C-up>", "<C-o><C-Y>" }
nnoremap { "<C-down>", "<C-E>" }
inoremap { "<C-down>", "<C-o><C-E>" }

-- delete a word from any position of the cursor on the current word
-- if you are on beginning, it deletes the entire word
-- if you are on middle, it deletes the entire word
-- if you are on end, it deletes the entire word
nnoremap { "<S-Del>", "diwi" }
inoremap { "<S-Del>", "<C-O>diw" }

-- copy text between quotes
-- or
-- copy the word under cursor
local shift_c_handler = function()
    local current_line = vim.fn.getline(".")
    local line_length = #current_line
    local col = vim.fn.col(".")

    local quotes_to_right = false
    local right_quote_index = nil
    for index = col + 1, line_length - 1 do
        -- http://lua-users.org/wiki/StringIndexing
        -- print(string.sub(current_line, index, index))
        if string.sub(current_line, index, index) == "\"" then
            quotes_to_right = true
            right_quote_index = index
            break
        end
    end

    local quotes_to_left = false
    local left_quote_index = nil
    for index = col - 1, -1, -1 do
        -- print(string.sub(current_line, index, index))
        if string.sub(current_line, index, index) == "\"" then
            quotes_to_left = true
            left_quote_index = index
            break
        end
    end

    local to_copy = nil
    if quotes_to_left and quotes_to_right then
        to_copy = string.sub(current_line, left_quote_index + 1,
                             right_quote_index - 1)
    else
        to_copy = vim.fn.expand("<cword>")
    end
    vim.fn.setreg("+", to_copy)
    vim.fn.setreg("\"", to_copy)
    print("copied '" .. to_copy .. "' to clipboard")
end


lua_nnoremap { "<S-c>", shift_c_handler }
-- nnoremap{"<S-c>", "\"+yi\""}

-- select all text between quotes (" ") including quotes
nnoremap { "<S-s>", "va\"" }

-- when normal mode enter insert mode and insert new line to write on the line
nnoremap { "<CR>", "o" }
-- new line before
nnoremap { "<A-cr>", "O" }
inoremap { "<A-cr>", "<C-o>o" }

-- navigate splitted panes
nnoremap { "<C-A-Left>", "<C-W>h" }
nnoremap { "<C-A-Right>", "<C-W>l" }
nnoremap { "<C-A-home>", "<C-W>k" }
nnoremap { "<C-A-end>", "<C-W>j" }

inoremap { "<C-A-Left>", co .. "<C-W>h" }
inoremap { "<C-A-Right>", co .. "<C-W>l" }
-- inoremap{"<C-A-Up>", co .. "<C-W>k"}
-- inoremap{"<C-A-Down>", co .. "<C-W>j"}

tnoremap { "<C-A-Left>", "<C-\\><C-N><C-W>h" }
tnoremap { "<C-A-Right>", "<C-\\><C-N><C-W>l" }
-- tnoremap{"<C-A-Up>", "<C-\\><C-N><C-W>k"}
-- tnoremap{"<C-A-Down>", "<C-\\><C-N><C-W>j"}

-- open url
nnoremap { "<C-space>", "gx" }

-- home and end to the actual home and end
-- inoremap{"<Home>", "<C-o>g^"}
-- inoremap{"<End>", "<C-o>g$"}
-- jump to the beginning of the line in insert mode without exiting insert mode
-- nnoremap{"<Home>", "g^"}
-- nnoremap{"<End>", "g$"}

-- previous visited tab
nnoremap { "<S-tab>", ":b#<CR>" }
inoremap { "<S-tab>", "<C-o>:b#<CR>" }

-- delete a word forward
nnoremap { "<C-Del>", "dwi" }
inoremap { "<C-Del>", "<C-O>dw" }
-- cw is better ca uneori vreau sa pastrez spatiu

-- select current line with control L
nnoremap { "<C-l>", "<S-v>\"+y<S-v><end>" }
inoremap { "<C-L>", "<Esc><S-v>\"+y<S-v><end>" }

-- word wrap
function ToggleWordWrap()
    if vim.wo.wrap == true then
        vim.wo.wrap = false
        print("line wrap is OFF")
    else
        vim.wo.wrap = true
        print("line wrap is ON")
    end
end


nnoremap { "<A-z>", ":lua ToggleWordWrap()<CR>" }

NVIM_INIT_LUA = os.getenv("NVIM_INIT_LUA")

-- reload neovim
function ReloadNeovim()
    local current_buffer_name = vim.fn.expand("%:t")
    vim.cmd("wa!")
    -- source init.lua
    vim.cmd("source ~/.config/nvim/init.lua")
    -- source plugins.lua
    vim.cmd("source ~/.config/nvim/init.lua")
    vim.cmd("e")

    -- source plugins.lua
    local current_time = vim.fn.strftime("%H:%M:%S")
    print("[init.lua] + [" .. current_buffer_name .. "] reloaded at " ..
              current_time)
end


nnoremap { "<F5>", ":lua ReloadNeovim()<CR>" }
inoremap { "<F5>", co .. ":lua ReloadNeovim()<CR>" }
vnoremap { "<F5>", esc .. ":lua ReloadNeovim()<CR>" }

-- delete file permanently
function DecisionPrompt(file_name)
    local decision = vim.fn.input("delete (permanently) file: " .. file_name ..
                                      " ?? [y/n]:\n>>> ")
    return decision
end


function DeleteFilePermanently()
    local file_name = vim.fn.expand("%:t")
    local decision = DecisionPrompt(file_name)
    if decision == "y" then
        vim.fn.delete(vim.fn.expand("%"))
        vim.cmd("bdelete!")
        -- print("\nfile deleted | action cannot be undone\n")
        -- print("buffer closed")
        vim.cmd("NvimTreeRefresh")
    else
        print("file deletion aborted")
    end
end


nnoremap { "<C-S-del>", ":lua DeleteFilePermanently()<CR>" }
inoremap { "<C-S-del>", co .. ":lua DeleteFilePermanently()<CR>" }

function StringSplit(string, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(string, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end


-- https://riptutorial.com/lua/example/2258/iterating-tables
function GetDirname(path)
    local splitted = StringSplit(path, "/")
    local dirname = "/"
    for i = 1, #splitted - 1 do dirname = dirname .. splitted[i] .. "/" end
    return dirname
end


-- create new file
-- https://vim.fandom.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts
function CreateNewFile()
    local fullpath = vim.fn.expand("%:p")
    local dirname = GetDirname(fullpath)
    local filename = vim.fn.input("new file: ")

    -- dirname has / at the end
    vim.cmd("e " .. dirname .. filename)
    vim.cmd("w!")
    -- print(filename .. " created at " .. vim.cmd("pwd"))
end


nnoremap { "<A-a>", ":lua CreateNewFile()<CR>" }
-- nnoremap{"<A-a>", ":lua CreateNewFile()<CR>"}
inoremap { "<A-a>", co .. ":lua CreateNewFile()<CR>" }
vnoremap { "<A-a>", esc .. ":lua CreateNewFile()<CR>" }

-- disable q in normal and visual mode
nnoremap { "q", "<nop>" }
vnoremap { "q", "<nop>" }

-- rename current buffer and file on disk
-- !!!experimental
function RenameFileAPI(newfile)
    -- vim.cmd("set cmdheight=10")
    local oldfile = vim.fn.bufname("%")
    vim.cmd("f " .. newfile)
    vim.cmd("w!")
    -- vim.cmd("e#")
    -- vim.cmd("bdelete! " .. oldfile)
    vim.cmd("!rm " .. oldfile)
    print("file [ " .. oldfile .. "] renamed => [" .. newfile .. "] ✅")
    -- vim.cmd("set cmdheight=1")
end


vim.cmd("command! -bang -nargs=1 Rename :lua RenameFileAPI(<q-args>)<CR>")

nnoremap { "<F26>", ":Rename <C-R>=bufname(\"%\")<CR>", false }
inoremap { "<F26>", co .. ":Rename <C-R>=bufname(\"%\")<CR>", false }
vnoremap { "<F26>", esc .. ":Rename <C-R>=bufname(\"%\")<CR>", false }

-- delete current line
inoremap { "<A-BS>", "<C-u>" }

-- copy word under cursor
--  https://gist.github.com/hectorperez/1f6cbe9a55bfb34e577a
--
--  doesnt copy to system's clipbard
-- nnoremap{"<A-s>", "\"+byw"}
-- inoremap{"<A-s>", "<C-o>\"+byw"}

-- trigger visual line from insert mode
inoremap { "<S-up>", co .. "<S-v>k" }
inoremap { "<S-down>", co .. "<S-v>j" }
vnoremap { "<S-up>", "<up>" }
vnoremap { "<S-down>", "<down>" }

-- trigger visual line from normal mode using shift
nnoremap { "<S-up>", "<S-v>k" }
nnoremap { "<S-down>", "<S-v>j" }

-- copy one character in normal mode
-- https://stackoverflow.com/questions/23323747/vim-vimscript-get-exact-character-under-the-cursor
-- local function copy_current_char_under_cursor()
-- in order for this to be called from vim command the function
-- must be global
function CopyCurrentCharUnderCursor()
    vim.cmd("normal \"+yl")
    local col = vim.fn.col(".")
    local row = vim.fn.getline(".")
    local char_under_cursor = string.sub(row, col, col)
    print("copied char '" .. char_under_cursor .. "' to clipboard")
end


nnoremap { "c", ":lua CopyCurrentCharUnderCursor()<CR>" }

-- http://lua-users.org/wiki/StringIndexing
--
--
--

-- trigger visual mode
-- select text on the same line with shift + left/right
-- just like vs code
nnoremap { "<S-left>", "v<left>" }
inoremap { "<S-left>", "<esc>v<left>" }
vnoremap { "<S-left>", "<left>" }

nnoremap { "<S-right>", "v<right>" }
inoremap { "<S-right>", "<c-o><right><esc>v<right>" }
vnoremap { "<S-right>", "<right>" }

-- hope line
nnoremap { "x", ":HopLine<CR>" }

nnoremap { "<S-q>", "ciw\"\"<esc>P" }

-- use arrows keys in wild menu, just like a normal menu
-- vim.opt.wildcharm='<C-Z>' -- error
-- vim.cmd[[set wildcharm=<C-Z>]]
-- cnoremap{"<up>", "wildmenumode() ? \"<left>\" : \"<up>\"", expr = true}
-- cnoremap{"<down>", "wildmenumode() ? \"<right>\" : \"<down>\"", expr = true}
-- cnoremap{"<left>", "wildmenumode() ? \"<up>\" : \"<left>\"", expr = true}
-- cnoremap{"<right>", "wildmenumode() ? \"<bs><C-Z>\" : \"<right>\"", expr = true}

local function jump_to_file()
    local ft = vim.bo.filetype
    local filename = vim.fn.expand("<cfile>")
    local http = "http://"
    local https = "https://"

    -- filename its an URL
    if string.sub(filename, 1, string.len(http)) == http or
        string.sub(filename, 1, string.len(https)) == https then
		os.execute("firefox " .. filename .. " & > /dev/null")
        -- vim.api.nvim_command("!firefox " .. filename)
        print("firefox: " .. filename)
        return
    end

    if ft == "toggleterm" then
        -- then open the file where the cursor is on at specified line number
        -- to do this you need to get the current line with
        -- vim.fn.getline(".")
    end
    -- TODO
    -- add support for toggle term
    -- and jump from terminal
    -- from python traceback
    -- file line 123
    local current_line = vim.fn.getline(".")
    -- print(filename, current_line)
    local colon_pos = string.find(current_line, ":", 1, true)
    if not colon_pos then
        print("not a file, colon_pos == nil; line 672; keybindings.lua")
        return
    end
    -- print(colon_pos)

    local number_string = ""
    for i = colon_pos + 1, #current_line do
        local char = string.sub(current_line, i, i)
        -- print(char)
        if char == "\n" then
            print("got end of line")
            break
        elseif char == " " then
            print("got space")
            break
        elseif tonumber(char) == nil then
            print("got non number")
            break
        end
        number_string = number_string .. char
    end
    print(number_string)
    vim.cmd("e " .. filename)
    vim.cmd(":" .. number_string)
end


lua_nnoremap { "<C-space>", jump_to_file }
lua_inoremap { "<C-space>", jump_to_file }
lua_vnoremap { "<C-space>", jump_to_file }
lua_nnoremap { "<leader>f", jump_to_file }



-- documentation popup when pressing Alt-d
nnoremap { "<A-d>", ":lua vim.lsp.buf.hover()<CR>" }
inoremap { "<A-d>", co .. ":lua vim.lsp.buf.hover()<CR>" }
