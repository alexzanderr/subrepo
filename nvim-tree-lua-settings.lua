-- nvim tree
--
-- plugin url
-- https://github.com/kyazdani42/nvim-tree.lua
-- https://www.chrisatmachine.com/Neovim/28-neovim-lua-development/
local core = require("core")
local nnoremap = core.nnoremap
local inoremap = core.inoremap
local vnoremap = core.vnoremap
local lua_nnoremap = core.lua_nnoremap
local lua_inoremap = core.lua_inoremap
local lua_vnoremap = core.lua_vnoremap

-- " default will show icon by default if no icon is provided
-- " default shows no icon by default

vim.g.nvim_tree_show_icons = {
    ["git"] = 1,
    ["folders"] = 1,
    ["files"] = 1,
    ["folder_arrows"] = 1
}

vim.g.nvim_tree_icons = {
    ["default"] = "",
    ["symlink"] = "",
    ["git"] = {
        ["unstaged"] = "✗",
        ["staged"] = "✓",
        ["unmerged"] = "",
        ["renamed"] = "➜",
        ["untracked"] = "★",
        ["deleted"] = "",
        ["ignored"] = "◌"
    },
    ["folder"] = {
        ["arrow_closed"] = "",
        ["arrow_open"] = "",
        ["default"] = "",
        ["open"] = "",
        ["empty"] = "",
        ["empty_open"] = "",
        ["symlink"] = "",
        ["symlink_open"] = ""
    }
	-- after the last update, these are deprecated
    -- ["lsp"] = {
    --     ["hint"] = "",
    --     ["info"] = "",
    --     ["warning"] = "",
    --     ["error"] = ""
    -- }
}

-- this solves the problem with when you close a file
-- after you opened it from nvim tree (entire neovim closes)
vim.g.nvim_tree_quit_on_open = 1

vim.g.nvim_tree_git_hl = 1

vim.g.nvim_tree_indent_markers = 0
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_window_picker_exclude = {
    ["filetype"] = { "notify", "packer", "qf", "Outline" },
    ["buftype"] = { "terminal" }
}
vim.g.nvim_tree_icon_padding = "  "
vim.g.nvim_tree_highlight_opened_files = 1
-- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.

local control_backslash_handler = function()
    local buffers = vim.fn.getbufinfo()
    local ft = vim.bo.filetype
    if ft == "NvimTree" then
        vim.cmd("NvimTreeClose")
        print("nvim tree closed")
    else
        local nvim_tree_is_opened = false
        -- https://stackoverflow.com/questions/10219419/distinguish-between-hidden-and-active-buffers-in-vim
        for index, _ in pairs(buffers) do
            -- print(buffers[index]["bufnr"], buffers[index]["name"])
            if vim.fn.bufwinnr(buffers[index]["bufnr"]) == 1 and
                string.find(buffers[index]["name"], "NvimTree") then
                nvim_tree_is_opened = true
                break
            end
        end
        if nvim_tree_is_opened then
            vim.cmd("NvimTreeClose")
            print("nvim tree closed")
        else
            vim.cmd("NvimTreeFindFile")
            print("file focused in nvim tree")
        end
    end
end


-- this is silent by default actually
-- but i looked into the source code
-- and i didnt see any silent = true
lua_nnoremap { "<c-\\>", control_backslash_handler }
lua_inoremap { "<c-\\>", control_backslash_handler }
lua_vnoremap { "<c-\\>", control_backslash_handler }


-- just the highlights, but well organized in lua table
local nvim_tree_highlights = {
    NvimTreeOpenedFolderName = { guifg = "#c4af10" },
    NvimTreeFolderIcon = { guifg = "#4e70d4" },
    NvimTreeIndentMarker = { guifg = "#5c6370" },
    NvimTreeLspDiagnosticsError = { guifg = "#db4b4b" },
    NvimTreeLspDiagnosticsHint = { guifg = "#934491" },
    NvimTreeLspDiagnosticsInformation = { guifg = "#10B981" },
    NvimTreeLspDiagnosticsWarning = { guifg = "#e0af68" },
    NvimTreeRootFolder = { guifg = "#c678dd" },
    NvimTreeExecFile = { guifg = "#b9ca4a" },
    -- the onfocused background color
    NvimTreeNormalNC = { guifg = "#abb2bf", guibg = "#21252b" },
    NvimTreeSignColumn = { guifg = "#abb2bf", guibg = "#21252b" },
    -- symlink
    NvimTreeSymlink = { guifg = "#70c0b1" },
    NvimTreeOpenedFile = { guifg = "#DBCE50", gui = "none" }
}

-- function to apply the above highlights
local function highlight_nvim_tree_components()
    local multiline_string = ""
    for highlight_group, args in pairs(nvim_tree_highlights) do
        local line = "hi " .. highlight_group .. " "
        -- print(highlight_group)
        for key, value in pairs(args) do
            -- print(key, value)
            line = line .. key .. "=" .. value .. " "
        end
        multiline_string = multiline_string .. line .. "\n"
    end
    vim.cmd(multiline_string)
end

-- calling the function
highlight_nvim_tree_components()

-- in padding.lua in nvim-tree source code modify this
-- local function get_padding_indent_markers(depth, idx, tree, _, markers)
--   local padding = ""
--   if depth ~= 0 then
--     local rdepth = depth/2
--     markers[rdepth] = idx ~= #tree.entries
--     for i=1,rdepth do
--       if idx == #tree.entries and i == rdepth then
--         padding = padding..'﹂ '
--       elseif markers[i] then
--         padding = padding..'▏ '
--       else
--         padding = padding..'  '
--       end
--     end
--   end
--   return padding
-- end

require"nvim-tree".setup {
    disable_netrw = true,
    hijack_netrw = true,
    -- open the tree when running this setup function
    open_on_setup = false,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup = {},
    -- closes neovim automatically when the tree is the last **WINDOW** in the view
    auto_close = true,
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab = true,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor = false,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    update_cwd = true,
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    -- 	    \   'empty': "",
    -- \   'empty_open': "",
    update_focused_file = {
        -- enables the feature
        enable = false,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_cwd = false,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {}
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
        -- the command to run this, leaving nil should work in most cases
        -- the command arguments as a list
        cmd = nil,
        args = {}
    },
    diagnostics = {
        enable = true,
        icons = { hint = "", info = "", warning = "", error = "" }
    }
}
