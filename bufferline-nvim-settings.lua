-- bufferline.nvim
--
-- plugin url
-- https://github.com/akinsho/bufferline.nvim
local bufferline = require("bufferline")
bufferline.setup {
    options = {
        numbers = function(opts)
            return string.format("%s ", opts.ordinal)
        end
,
        -- numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        -- numbers = function({ ordinal }): "ordinal",
        -- numb= "superscript" | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
        -- number_style = "superscript", -- buffer_id at index 1, ordinal at index 2
        close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        -- NOTE: this plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- as an escape hatch for people who cannot bear it for whatever reason
        indicator_icon = "▎",
        buffer_close_icon = "",
        modified_icon = "●",
        -- modified_icon = '[+]',
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
        --   -- remove extension from markdown files for example
        --   if buf.name:match('%.md') then
        --     return vim.fn.fnamemodify(buf.name, ':t:r')
        --   end
        -- end,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        -- diagnostics = false | "nvim_lsp" | "coc",
        --
        -- its possible that this is taking performance on large projects
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        -- return "("..count..")"
        -- end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        -- custom_filter = function(buf_number)
        --   -- filter out filetypes you don't want to see
        --   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        --     return true
        --   end
        --   -- filter out by buffer name
        --   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        --     return true
        --   end
        --   -- filter out based on arbitrary rules
        --   -- e.g. filter out vim wiki buffer from tabline in your work repo
        --   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        --     return true
        --   end
        -- end,
        -- text_align = "left" | "center" | "right"}},
        offsets = {
            {
                filetype = "NvimTree",
                text = function ()
                	return vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '')
                end,
                text_align = "center",
                highlight = "OffsetLine",
            },
        },
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        -- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
        -- separator_style = "thick", -- this is very good
        separator_style = "slant",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
        --   -- add custom logic
        --  return buffer_a.modified > buffer_b.modified
        -- end
        custom_areas = {
            -- 		right = function()
            -- 			local result = {}
            -- 			local error = vim.lsp.diagnostic.get_count(0, [[Error]])
            -- 			local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
            -- 			local info = vim.lsp.diagnostic.get_count(0, [[Information]])
            -- 			local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

            -- 			if error ~= 0 then
            -- 				table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
            -- 			end

            -- 			if warning ~= 0 then
            -- 				table.insert(result, {text = "  " .. warning, guifg = "#EFB839"})
            -- 			end

            -- 			if hint ~= 0 then
            -- 				table.insert(result, {text = "  " .. hint, guifg = "#A3BA5E"})
            -- 			end

            -- 			if info ~= 0 then
            -- 				table.insert(result, {text = "  " .. info, guifg = "#7EA9A7"})
            -- 			end
            -- 			return result
            -- 		end,
            -- 		not working
            right = function()
                local result = {}
                table.insert(result, {
                    text = "  " .. info,
                    guifg = "#7EA9A7",
                })
                return result
            end
,
        },
    },

}

local map = vim.api.nvim_set_keymap
local noremap_silent = {
    noremap = true,
    silent = true,
}

-- with this you can run a single normal mode command
-- in insert mode
-- control + o
local co = "<C-o>"
local esc = "<esc>"
-- string concatenation in lua
-- https://www.lua.org/pil/3.4.html

-- go to left buffer
map("n", "<C-pagedown>", ":BufferLineCycleNext<CR>", noremap_silent)
map("v", "<C-pagedown>", esc .. ":BufferLineCycleNext<CR>", noremap_silent)
map("i", "<C-pagedown>", co .. ":BufferLineCycleNext<CR>", noremap_silent)

-- go to right buffer
map("n", "<C-pageup>", ":BufferLineCyclePrev<CR>", noremap_silent)
map("v", "<C-pageup>", esc .. ":BufferLineCyclePrev<CR>", noremap_silent)
map("i", "<C-pageup>", co .. ":BufferLineCyclePrev<CR>", noremap_silent)

-- move current buffer to left
map("n", "<C-S-pagedown>", ":BufferLineMoveNext<CR>", noremap_silent)
map("v", "<C-S-pagedown>", esc .. ":BufferLineMoveNext<CR>", noremap_silent)
map("i", "<C-S-pagedown>", co .. ":BufferLineMoveNe<CR>", noremap_silent)

-- more current buffer to right
map("n", "<C-S-pageup>", ":BufferLineMovePrev<CR>", noremap_silent)
map("v", "<C-S-pageup>", esc .. ":BufferLineMovePrev<CR>", noremap_silent)
map("i", "<C-S-pageup>", co .. ":BufferLineMovePrev<CR>", noremap_silent)

-- quickscope for buffers
map("n", "<S-a>", ":BufferLinePick<CR>", noremap_silent)

-- close current buffer
-- with ! you will close the buffer even if has unsaved changes
map("n", "<F25>", ":bdelete!<CR>", noremap_silent)
map("i", "<F25>", co .. ":bdelete!<CR>", noremap_silent)
map("v", "<F25>", esc .. ":bdelete!<CR>", noremap_silent)



-- its not the same color as the bufferline black background
-- but its very close
vim.cmd("hi OffsetLine guibg=#16181c")
