
--
-- theme.lua
--
-- colors customization file
--
-- colorscheme should be required first
-- because colorscheme is overriding my colors
--
-- TODO for this file
-- 	"add function hook to autocmd ColorScheme event to reapply all my custom colors for example text selection; this implies a custom theme.lua file to have a function with all the highlights that should be reloaded",

--
vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme solarized")

vim.cmd[[
	match HighlightURL /http[s]\?:\/\/[[:alnum:]-%\/_#.-@?=]*/
	autocmd ColorScheme * :lua ApplyAlexzanderTheme()
]]


local theme = {
    VertSplit = { ctermfg = "NONE ", guifg = "#1f2227" },
    CursorLineNR = { guifg = "#D9C650" },
    CursorLine = { guibg = "#1f2227" },
    NvimTreeCursorLine = { guibg = "#1f2227" },
    -- hi Visual guifg=#282828 guibg=#d79921
    Visual = { guifg = "#282828", guibg = "#BCA633" },
    -- hi Visual guifg=none guibg=#242424 gui=inverse
    ErrorMsg = { guifg = "#db4b4b" },
    Error = { guifg = "#db4b4b" },
	-- the '~' character at the end of buffer
	EndOfBuffer = { guifg="#c4af10"},
	HighlightURL = { guifg="#a15bbd", gui="italic,underline" }
}
-- function to apply the above highlights
function ApplyAlexzanderTheme()
    local multiline_string = ""
    for highlight_group, args in pairs(theme) do
        local line = "hi " .. highlight_group .. " "
        for key, value in pairs(args) do
            line = line .. key .. "=" .. value .. " "
        end
        multiline_string = multiline_string .. line .. "\n"
    end
    vim.cmd(multiline_string)
end

ApplyAlexzanderTheme()

