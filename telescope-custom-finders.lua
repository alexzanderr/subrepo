-- in lua/finders.lua
local telescope_custom_finders = {}

-- Dropdown list theme using a builtin theme definitions :
local center_list = require"telescope.themes".get_dropdown({
    winblend = 10,
    layout_config = {
        width = 0.6,
    },
    prompt = " ",
    -- results_height = 15,
    previewer = false,
})

-- Settings for with preview option
local with_preview = {
    winblend = 10,
    show_line = false,
    results_title = false,
    preview_title = false,
    layout_config = {
        preview_width = 0.5,
    },
}

-- Find in neovim config with center theme
telescope_custom_finders.change_colorscheme = function()
    local opts = vim.deepcopy(center_list)
    opts.prompt_prefix = "Colorschemes ➤  "
    opts.cwd = vim.fn.stdpath("config")
    require"telescope.builtin".colorscheme(opts)
end


-- make sure to map it:
--
vim.cmd [[
	nnoremap <leader>ff :lua require'finders'.change_colorscheme()<cr>
]]











return telescope_custom_finders
