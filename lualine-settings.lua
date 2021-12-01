-- plugin url
-- https://github.com/hoob3rt/lualine.nvim
-- themes
-- https://github.com/hoob3rt/lualine.nvim/blob/master/THEMES.md
-- options = {
--     theme = 'onedark'
-- }
-- require'lualine'.setup({options})
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")

-- Color table for highlights
local colors = {
    bg = "#202328",
    -- bg = "#16181c",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67"
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end
,
    hide_in_width = function() return vim.fn.winwidth(0) > 80 end
,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end


}

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = "",
        section_separators = "",
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } }
        },
        disabled_filetypes = {}

    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {}
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_v = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {}
    }
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end


-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end


-- ins_left {
--     function()
-- 		return ""
--         -- return "▊"
--     end
-- ,
--     color = {
--         fg = colors.blue,
--     }, -- Sets highlighting of component
--     left_padding = 0, -- We don't need space before this
-- }

ins_left {
    -- mode component
    function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red
        }
        vim.api.nvim_command("hi! LualineMode guifg=" ..
                                 mode_color[vim.fn.mode()] .. " guibg=" ..
                                 colors.bg)
        return ""
    end
,
    color = "LualineMode",
    left_padding = 0
}

-- ins_left {
--     -- filesize component
--     function()
--         local function format_file_size(file)
--             local size = vim.fn.getfsize(file)
--             if size <= 0 then
--                 return ""
--             end
--             local sufixes = {
--                 "b",
--                 "k",
--                 "m",
--                 "g",
--             }
--             local i = 1
--             while size > 1024 do
--                 size = size / 1024
--                 i = i + 1
--             end
--             return string.format("%.1f%s", size, sufixes[i])
--         end

--         local file = vim.fn.expand("%:p")
--         if string.len(file) == 0 then
--             return ""
--         end
--         return format_file_size(file)
--     end
-- ,
--     condition = conditions.buffer_not_empty,
-- }
--
--
--
--
-- this is just a template
-- ins_right {
--     function()
-- 		return ""
--         -- return "▊"
--     end
-- ,
--     color = {
--         fg = colors.blue,
--     },
--     right_padding = 0,
-- }
--

function is_ft_tree() return vim.bo.filetype == "NvimTree" end


local filetypes_logos = {
    python = "",
    markdown = "",
    lua = "",
    javascript = "",
    config = "",
    yaml = "",
    bash = " ",
    sh = " ",
    zsh = " ",
    c = "",
    cpp = "",
    jsx = "",
    json = "",
    css = "",
    html = "",
    htm = "",
    vue = "﵂",
    sql = "",
    go = "",
    rust = "",
    rs = "",
    typescript = ""
}

function select_foreground()
    if is_ft_tree() then
        return colors.green
    else
        return colors.red
    end
end


function get_file_icon()
    local ft = vim.bo.filetype
    if is_ft_tree() then return "🌲" end

    if filetypes_logos[ft] ~= nil then return filetypes_logos[ft] end

    return ""
end


-- filetype icon
-- ins_left {
--     function() return get_file_icon() end
-- ,
--     color = { fg = select_foreground() }
-- }

-- filename
ins_left {
    function()
        local filename = vim.fn.bufname("%")
		local folder_name = vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '')
        -- local relative_path = vim.fn.expand("%:h"):
        -- local filetype = vim.bo.filetype
        -- if filetypes_logos[filetype] ~= nil then
        -- 	return filetypes_logos[filetype] .. " " .. filename
        -- elseif filetype == "NvimTree" then
        -- 	return "🌲"
        -- end
		if is_ft_tree() then
			return get_file_icon() .. " " .. filename
		end
        return " " .. folder_name .. " / " .. get_file_icon() .. " " .. filename
    end
,
    condition = conditions.buffer_not_empty,
    color = {
        fg = colors.magenta
        -- bg = colors.orange
        -- making these bold, makes the glyph smaller
        -- gui = "bold",
    }
}

-- ins_left {
-- 	function ()
-- 		return ""
-- 	end
-- }

-- location in file
ins_left {
    function()
        local current_line_number = vim.fn.line(".")
        -- https://stackoverflow.com/questions/13372621/in-vim-how-do-you-get-the-number-of-lines-in-the-current-file-using-vimscript
        local total_lines = vim.fn.line("$")
        if is_ft_tree() then return "" end
        return " " .. current_line_number .. "/" .. total_lines
        -- return current_line_number .. "/" .. total_lines .. " ❯"
        -- return current_line_number .. "/" .. total_lines .. "\u{e0b1}"
    end
,
    "location"
}

-- ins_left {
--     function ()
--     	-- :lua print(string.format("%.2f %%", vim.fn.line('.') * 100 / vim.fn.line('$')))
-- 		local location_percentage = math.floor(vim.fn.line('.') * 100 / vim.fn.line('$'))
-- 		-- percentage doesnt appear, lol
-- 		return location_percentage .. "%"
--     end,
--     color = {
--         fg = colors.fg,
--         gui = "bold",
--     },
-- }

-- ins_left{ function ()
-- 	return "asd"
-- end}

ins_left {
    "diagnostics",
    sources = { "nvim_lsp" },
    symbols = { error = " ", warn = " ", info = " " },
    color_error = colors.red,
    color_warn = colors.yellow,
    color_info = colors.cyan
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
    function() return "%=" end


}

ins_left {
    -- Lsp server name .
    function()
        if is_ft_tree() then return "" end
        local msg = "none"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then return msg end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return " LSP: " .. client.name
            end
        end
        return " LSP: " .. msg
    end
,
    -- icon = " LSP:",
    -- icon = " LSP:",
    color = {
        -- fg = "#ffffff",
        -- fg = "#0b7eb8",
        -- fg = "#32b7fa",
        fg = "#FF8800"
    }
}

ins_left {
	function()
		-- return "TS:  "
		return "TS: 🌴 "
	end,
	color = {
		fg = colors.green
	}
}

-- Add components to right sections
-- ins_right {
--     "o:encoding", -- option component same as &encoding in viml
--     upper = true, -- I'm not sure why it's upper case either ;)
--     condition = conditions.hide_in_width,
--     color = {
--         fg = colors.green,
--         gui = "bold",
--     },
-- }

-- ins_right {
--     "fileformat",
--     upper = true,
--     icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--     color = {
--         fg = colors.green,
--         gui = "bold",
--     },
-- }

ins_right {
	function ()
		return get_file_icon() ..  " " .. vim.bo.filetype
	end,
	color = {
		fg = colors.yellow
	}
}

ins_right {
    -- TODO
    -- remove this is the filetype is nvim tree
    "branch",
    icon = "",
    -- icon = "",
    condition = conditions.check_git_workspace,
    color = { fg = colors.violet }
}

ins_right {
    "diff",
    -- Is it me or the symbol for modified us really weird
    symbols = { added = " ", modified = "柳", removed = " " },
    color_added = colors.green,
    color_modified = colors.orange,
    color_removed = colors.red,
    condition = conditions.hide_in_width
}

-- ins_right {
--     function()
-- 		return ""
--         -- return "▊"
--     end
-- ,
--     color = {
--         fg = colors.blue,
--     },
--     right_padding = 0,
-- }

-- Now don't forget to initialize lualine
lualine.setup(config)
