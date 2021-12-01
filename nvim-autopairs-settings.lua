-- nvim-autopairs
--
-- plugin url
-- https://github.com/windwp/nvim-autopairs
--
--
-- custom rules
-- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules
local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require "nvim-autopairs.conds"


autopairs.setup {
    disable_filetype = { "TelescopePrompt", "NvimTree", "Outline", "toggleterm" },
    -- ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
    enable_moveright = true,
    enable_afterquote = true,
    enable_check_bracket_line = true,
    map_bs = true,
    map_c_w = true,
    fast_wrap = {
        map = "<M-p>",
        chars = { "{", "[", "(", "\"", "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "0",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        hightlight = "Search"
    },
	-- check treesitter for validity
    check_ts = false,
    ts_config = {
		python = {"string"},
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    },
}

-- Add spaces between parentheses
-- Before 	Insert 	After
-- (|) 	    space 	( | )
-- ( | ) 	) 	    ( )|
autopairs.add_rules {
    Rule(" ", " "):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end
),
    Rule("( ", " )"):with_pair(function() return false end
):with_move(function(opts) return opts.prev_char:match(".%)") ~= nil end
):use_key(")"),
    Rule("{ ", " }"):with_pair(function() return false end
):with_move(function(opts) return opts.prev_char:match(".%}") ~= nil end
):use_key("}"),
    Rule("[ ", " ]"):with_pair(function() return false end
):with_move(function(opts) return opts.prev_char:match(".%]") ~= nil end
):use_key("]")
}

-- arrow key on javascript
-- Before 	Insert 	After
autopairs.add_rules {
    -- (item)= 	> 	    (item)=> { }
    Rule("%(.*%)%s*%=>$", " {  }",
         { "typescript", "typescriptreact", "javascript" }):use_regex(true)
        :set_end_pair_length(2)
}

-- -- auto addspace on =
-- -- Before 	        Insert 	After
-- -- local data 	    = 	    local data =
-- -- local data = 	= 	    local data ==
-- autopairs.add_rules {
--   Rule('=', '')
--     :with_pair(cond.not_inside_quote())
--     :with_pair(function(opts)
--         local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
--         if last_char:match('[%w%=%s]') then
--             return true
--         end
--         return false
--     end)
--     :replace_endpair(function(opts)
--         local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
--         local next_char = opts.line:sub(opts.col, opts.col)
--         next_char = next_char == ' ' and '' or ' '
--         if prev_2char:match('%w$') then
--             return '<bs> =' .. next_char
--         end
--         if prev_2char:match('%=$') then
--             return next_char
--         end
--         if prev_2char:match('=') then
--             return '<bs><bs>=' .. next_char
--         end
--         return ''
--     end)
--     :set_end_pair_length(0)
--     :with_move(cond.none())
--     :with_del(cond.none())

-- }



-- you need setup cmp first put this after cmp.setup()
-- cica e deprecated si acum trebuie sa mapezi CR in cmp
-- require("nvim-autopairs.completion.cmp").setup({
--     -- you can map in silence cr in the cmp setup
--     -- with this true you cannot map cr in cmp
--     map_cr = true, --  map <CR> on insert mode

--     -- this is the mapping that helped to cancel auto complete with enter and insert new line
--     map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
--     auto_select = false, -- automatically select the first item
--     insert = false, -- use insert confirm behavior instead of replace
--     map_char = { -- modifies the function or method delimiter by filetypes
--         all = "(",
--         tex = "{"
--     },

-- })
