-- git signs
--
-- plugin url
-- https://github.com/lewis6991/gitsigns.nvim
--
--
local gitsigns_unicode_sign = "⎢"
-- local gitsigns_unicode_sign = "▊"

require("gitsigns").setup {
    signs = {
        add = {
            hl = "GitSignsAdd",
            text = gitsigns_unicode_sign,
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn"
        },
        change = {
            hl = "GitSignsChange",
            text = gitsigns_unicode_sign,
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn"
        },
        delete = {
            hl = "GitSignsDelete",
            text = gitsigns_unicode_sign,
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn"
        },
        topdelete = {
            hl = "GitSignsDelete",
            text = gitsigns_unicode_sign,
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn"
        },
        changedelete = {
            hl = "GitSignsChange",
            text = gitsigns_unicode_sign,
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn"
        }
    },
    -- enables the column for signs, without this; no git hunks
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`

    -- colors the numbers of the line number
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`

    -- colors the entire line, so you can achieve diff mode in nvim
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`

    -- colors only the diff
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    -- keymaps = {
    --   -- Default keymap options
    --   noremap = true,

    --   ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    --   ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    --   ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    --   ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    --   ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    --   ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    --   ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    --   ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    --   ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    --   ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    --   ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    --   ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    --   -- Text objects
    --   ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    --   ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
    -- },
    watch_gitdir = { interval = 1000, follow_files = true },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000
    },
    current_line_blame_formatter_opts = { relative_time = false },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1
    },
    yadm = { enable = false }
}

-- vim.cmd("hi GitSignsChange guifg=yellow")
-- vim.cmd("hi GitSignsChange guifg=#ffd280")
vim.cmd("hi GitSignsChange guifg=#f79b2a")
vim.cmd("hi GitSignsChangeNr guifg=#f79b2a")
-- vim.cmd("hi GitSignsChangeNr guifg=#ffd280")

local core = require("core")
local nnoremap = core.nnoremap
local inoremap = core.inoremap
local co = core.co


-- go to next git hunk
-- normal mode
nnoremap { "<A-l>", ":lua require\"gitsigns.actions\".next_hunk()<CR>" }
-- insert mode
inoremap { "<A-l>", co .. ":lua require\"gitsigns.actions\".next_hunk()<CR>" }

-- preview next hunk
nnoremap {"<A-m>", ":lua require\"gitsigns\".preview_hunk()<CR>"}
inoremap {"<A-m>", co .. ":lua require\"gitsigns\".preview_hunk()<CR>"}

-- git blame line
nnoremap { "<A-b>", "lua require\"gitsigns\".blame_line(true)"}
inoremap { "<A-b>", co .. "lua require\"gitsigns\".blame_line(true)"}
