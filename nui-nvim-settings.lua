local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local Split = require("nui.split")

local clock = os.clock
function Sleep(n)
    local t0 = clock()
    while clock() - t0 <= n do
    end
end



local lines = vim.fn.winheight("%")
local columns = vim.fn.winwidth("%")
local treesitter_statusline = Popup({
	border = {},
	enter = false,
	focusable = false,
	relative = "win",
	-- position = {
	--     row = lines - 2,
	--     col = 0,
	-- },
	position = {
		row = "99%",
		col = "0%",
	},
	-- zindex = 50,
	size = {
		width = "100%",
		height = 1,
	},
	buf_options = {
		modifiable = true,
		readonly = false,
	},
	-- transparency
	-- win_options = {
	--     winblend = 0,
	--     winhighlight = "Normal:Normal",
	-- },

})


function TreeSitterStatusline()
    -- mount/open the component
    --

    treesitter_statusline:mount()

    --
    -- 	treesitter_statusline:on(event.VimResized, function()
    -- 		treesitter_statusline:unmount()
    -- 	end)
    --
    -- 	treesitter_statusline:on(event.BufLeave, function()
    -- 		treesitter_statusline:unmount()
    -- 	end)

    local lsp_status = require("nvim-treesitter").statusline({
        indicator_size = 200,
        separator = " ❱ ",
        transform_fn = function(line)
            return line:gsub("%s*[%[%(%{]*%s*$", "")
        end,

        type_patterns = {
            "class",
            "function",
            "method",
            "import",
            "for",
            "if",
            "while",
            "variable",
            "comment",
        },
    })
    --
    -- 	local gps = require("nvim-gps").setup({
    --         separator = " ❱ ",
    -- 	})
    --
    --
    --
    -- local lsp_status = require("nvim-gps").get_location()

    vim.api.nvim_buf_set_lines(treesitter_statusline.bufnr, 0, 1, false,
                               {
        lsp_status,
    })
    -- Sleep(1)
    -- treesitter_statusline:unmount()
    -- treesitter_statusline:unmount()
end


-- http://vimdoc.sourceforge.net/htmldoc/autocmd.html#autocmd-events
-- vim.cmd("autocmd CursorMoved * lua TreeSitterStatusline()")
-- vim.cmd("autocmd CursorMovedI * lua TreeSitterStatusline()")

-- without this you are garbage

vim.cmd("autocmd CursorHold * lua TreeSitterStatusline()")
vim.cmd("autocmd CursorHoldI * lua TreeSitterStatusline()")
vim.cmd("autocmd BufWrite * lua TreeSitterStatusline()")
-- vim.cmd("autocmd BufEnter * lua TreeSitterStatusline()")


function ReloadTreeSitterStatusline()
-- 	treesitter_statusline = Popup({
-- 		border = {},
-- 		enter = false,
-- 		focusable = false,
-- 		relative = "win",
-- 		-- position = {
-- 		--     row = lines - 2,
-- 		--     col = 0,
-- 		-- },
-- 		position = {
-- 			row = "99%",
-- 			col = "0%",
-- 		},
-- 		-- zindex = 50,
-- 		size = {
-- 			width = "100%",
-- 			height = 1,
-- 		},
-- 		buf_options = {
-- 			modifiable = true,
-- 			readonly = false,
-- 		},
-- 		-- transparency
-- 		-- win_options = {
-- 		--     winblend = 0,
-- 		--     winhighlight = "Normal:Normal",
-- 		-- },
--
-- 	})


	treesitter_statusline:unmount()
	TreeSitterStatusline()
end

function CloseTreeSitterStatusline()
	treesitter_statusline:unmount()
end

-- vim.cmd[[ autocmd User TelescopePreviewerLoaded * lua CloseTreeSitterStatusline() ]]


vim.cmd("autocmd VimResized * lua ReloadTreeSitterStatusline()")
