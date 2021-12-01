-- fzf-lua
--
-- plugin url
--
local actions = require "fzf-lua.actions"
local configuration = {
    winopts = {
        -- split         = "belowright new",-- open in a split instead?
        -- "belowright new"  : split below
        -- "belowright vnew" : split right
        -- "aboveleft vnew   : split left
        -- "aboveleft new"   : split above
        win_height = 0.9, -- window height
        win_width = 1, -- window width
        win_row = 0.30, -- window row position (0=top, 1=bottom)
        win_col = 0.50, -- window col position (0=left, 1=right)
        win_border = false, -- window border? or borderchars?
        -- win_border       = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        hl_normal = "Normal", -- window normal color
        hl_border = "FloatBorder", -- window border color
    },
    -- fzf_bin             = 'sk',        -- use skim instead of fzf?
    fzf_layout = "default", -- fzf '--layout=' options
    fzf_args = "--exact -i -m --info=default",
    fzf_info = "--info=default", -- adv: fzf extra args, empty unless adv
    fzf_binds = { -- fzf '--bind=' options
        ["f2"] = "toggle-preview",
        ["f3"] = "toggle-preview-wrap",
        ["shift-down"] = "preview-page-down",
        ["shift-up"] = "preview-page-up",
        ["ctrl-u"] = "unix-line-discard",
        ["ctrl-f"] = "half-page-down",
        ["ctrl-b"] = "half-page-up",
        ["ctrl-a"] = "beginning-of-line",
        ["ctrl-e"] = "end-of-line",
        ["alt-a"] = "toggle-all",
        ["esc"] = "abort",
    },
    fzf_colors = { -- fzf '--color=' options
        ["fg"] = {
            "fg",
            "CursorLine",
        },
        ["bg"] = {
            "bg",
            "Normal",
        },
        ["hl"] = {
            "fg",
            "Comment",
        },
        ["fg+"] = {
            "fg",
            "Normal",
        },
        ["bg+"] = {
            "bg",
            "CursorLine",
        },
        ["hl+"] = {
            "fg",
            "Statement",
        },
        ["info"] = {
            "fg",
            "PreProc",
        },
        ["prompt"] = {
            "fg",
            "Conditional",
        },
        ["pointer"] = {
            "fg",
            "Exception",
        },
        ["marker"] = {
            "fg",
            "Keyword",
        },
        ["spinner"] = {
            "fg",
            "Label",
        },
        ["header"] = {
            "fg",
            "Comment",
        },
        ["gutter"] = {
            "bg",
            "Normal",
        },
    },
    preview_border = "noborder", -- border|noborder
    preview_wrap = "nowrap", -- wrap|nowrap
    preview_opts = "nohidden", -- hidden|nohidden
    preview_vertical = "left:50%", -- up|down:size
    preview_horizontal = "left:50%", -- right|left:size
    preview_layout = "vertical", -- horizontal|vertical|flex
    flip_columns = 120, -- #cols to switch to horizontal on flex
    default_previewer   = "bat_native",       -- override the default previewer?
    -- by default uses the builtin previewer
    previewers = {
        cat = {
            cmd = "cat",
            args = "--number",
        },
        bat = {
            cmd = "bat",
            args = "--style=numbers,changes --color always",
            theme = "Coldark-Dark", -- bat preview theme (bat --list-themes)
            config = nil, -- nil uses $BAT_CONFIG_PATH
        },
        head = {
            cmd = "head",
            args = nil,
        },
        git_diff = {
            cmd = "git diff",
            args = "--color",
        },
        builtin = {
            title = true, -- preview title?
            scrollbar = false, -- scrollbar?
            -- scrollchar      = '█',          -- scrollbar character
            wrap = true, -- wrap lines?
            syntax = true, -- preview syntax highlight?
            syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
            syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
            expand = false, -- preview max size?
            hl_cursor = "Cursor", -- cursor highlight
            hl_cursorline = "CursorLine", -- cursor line highlight
            hl_range = "IncSearch", -- ranger highlight (not yet in use)
            keymap = {
                toggle_full = "<F2>", -- toggle full screen
                toggle_wrap = "<F3>", -- toggle line wrap
                toggle_hide = "<F4>", -- toggle on/off (not yet in use)
                page_up = "<S-up>", -- preview scroll up
                page_down = "<S-down>", -- preview scroll down
                page_reset = "<S-left>", -- reset scroll to orig pos
            },
        },
    },
    -- provider setup
    files = {
        -- previewer         = "cat",       -- uncomment to override previewer
        prompt = "Files❯ ",
        cmd = "", -- "find . -type f -printf '%P\n'",
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        actions = {
            -- set bind to 'false' to disable
            ["default"] = actions.file_edit,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["alt-q"] = actions.file_sel_to_qf,
            -- custom actions are available too
            ["ctrl-y"] = function(selected)
                print(selected[2])
            end
,
            -- ["esc"] = actions.close
        },
    },
    git = {
        files = {
            prompt = "GitFiles❯ ",
            cmd = "git ls-files --exclude-standard",
            git_icons = true, -- show git icons?
            file_icons = true, -- show file icons?
            color_icons = true, -- colorize file|git icons
        },
        status = {
            prompt = "GitStatus❯ ",
            cmd = "git status -s",
            previewer = "git_diff",
            file_icons = true,
            git_icons = true,
            color_icons = true,
        },
        commits = {
            prompt = "Commits❯ ",
            cmd = "git log --pretty=oneline --abbrev-commit --color --reflog",
            preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
            actions = {
                ["default"] = actions.git_checkout,
            },
        },
        bcommits = {
            prompt = "BCommits❯ ",
            cmd = "git log --pretty=oneline --abbrev-commit --color --reflog",
            preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
            actions = {
                ["default"] = actions.git_buf_edit,
                ["ctrl-s"] = actions.git_buf_split,
                ["ctrl-v"] = actions.git_buf_vsplit,
                ["ctrl-t"] = actions.git_buf_tabedit,
            },
        },
        branches = {
            prompt = "Branches❯ ",
            cmd = "git branch --all --color",
            preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
            actions = {
                ["default"] = actions.git_switch,
            },
        },
        icons = {
            ["M"] = {
                icon = "M",
                color = "yellow",
            },
            ["D"] = {
                icon = "D",
                color = "red",
            },
            ["A"] = {
                icon = "A",
                color = "green",
            },
            ["?"] = {
                icon = "?",
                color = "magenta",
            },
            -- ["M"]          = { icon = "★", color = "red" },
            -- ["D"]          = { icon = "✗", color = "red" },
            -- ["A"]          = { icon = "+", color = "green" },
        },
    },
    grep = {
        prompt = "Rg❯ ",
        input_prompt = "Grep For❯ ",
        -- cmd               = "rg --vimgrep",
        rg_opts = "--hidden --column --line-number --no-heading " ..
            "--color=always --smart-case -g '!{.git,node_modules}/*'",
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
    },
    oldfiles = {
        prompt = "History❯ ",
        cwd_only = false,
    },
    buffers = {
        -- previewer      = false,        -- disable the builtin previewer?
        prompt = "Buffers❯ ",
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        sort_lastused = true, -- sort buffers() by last used
        actions = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
            ["ctrl-x"] = actions.buf_del,
        },
    },
    blines = {
        previewer = "builtin", -- set to 'false' to disable
        prompt = "BLines❯ ",
        actions = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
        },
    },
    colorschemes = {
        prompt = "Colorschemes❯ ",
        live_preview = true, -- apply the colorscheme on preview?
        actions = {
            ["default"] = actions.colorscheme,
            ["ctrl-y"] = function(selected)
                print(selected[2])
            end
,
        },
        winopts = {
            win_height = 0.55,
            win_width = 0.30,
        },
        post_reset_cb = function()
            -- reset statusline highlights after
            -- a live_preview of the colorscheme
            -- require('feline').reset_highlights()
        end
,
    },
    quickfix = {
        -- cwd               = vim.loop.cwd(),
        file_icons = true,
        git_icons = true,
    },
    lsp = {
        prompt = "❯ ",
        -- cwd               = vim.loop.cwd(),
        cwd_only = false, -- LSP/diagnostics for cwd only?
        async_or_timeout = true, -- timeout(ms) or false for blocking calls
        file_icons = true,
        git_icons = false,
        lsp_icons = true,
        severity = "hint",
        icons = {
            ["Error"] = {
                icon = "",
                color = "red",
            }, -- error
            ["Warning"] = {
                icon = "",
                color = "yellow",
            }, -- warning
            ["Information"] = {
                icon = "",
                color = "blue",
            }, -- info
            ["Hint"] = {
                icon = "",
                color = "magenta",
            }, -- hint
        },
    },
    -- uncomment to disable the previewer
    -- nvim = { marks    = { previewer = { _ctor = false } } },
    -- helptags = { previewer = { _ctor = false } },
    -- manpages = { previewer = { _ctor = false } },
    -- uncomment to set dummy win location (help|man bar)
    -- "topleft"  : up
    -- "botright" : down
    -- helptags = { previewer = { split = "topleft" } },
    -- manpages = { previewer = { split = "topleft" } },
    -- uncomment to use `man` command as native fzf previewer
    -- manpages = { previewer = { _ctor = require'fzf-lua.previewer'.fzf.man_pages } },
    -- optional override of file extension icon colors
    -- available colors (terminal):
    --    clear, bold, black, red, green, yellow
    --    blue, magenta, cyan, grey, dark_grey, white
    -- padding can help kitty term users with
    -- double-width icon rendering
    file_icon_padding = "",
    file_icon_colors = {
        ["lua"] = "blue",
    },
}

local noremap_silent = {
    noremap = true,
    silent = true,
}

local noremap_silent_expr = {
    noremap = true,
    silent = true,
    expr = true,
}

-- nnoremap function
local nnoremap = function(trigger_key, command)
    vim.api.nvim_set_keymap("n", trigger_key, command, noremap_silent)
end


-- vnoremap function
local inoremap = function(trigger_key, command)
    vim.api.nvim_set_keymap("i", trigger_key, command, noremap_silent)
end


-- vnoremap function
local vnoremap = function(trigger_key, command)
    vim.api.nvim_set_keymap("v", trigger_key, command, noremap_silent)
end


-- tnoremap function (terminal mode)
local tnoremap = function(trigger_key, command)
    vim.api.nvim_set_keymap("t", trigger_key, command, noremap_silent)
end


require("fzf-lua").setup(configuration)
-- require("fzf-lua").setup({
--     fzf_args = "--border=none --exact -i -m --cycle --pointer='>' --layout=reverse-list --preview-window=left,50%"
-- })

nnoremap("<C-f>", ":FzfLua files<CR>")
inoremap("<C-f>", "<C-o>:FzfLua files<CR>")

nnoremap("<C-k><C-t>", ":FzfLua colorschemes<CR>")
inoremap("<C-o><C-k><C-t>", ":FzfLua colorschemes<CR>")

nnoremap("<S-f>", ":FzfLua live_grep<CR>")

nnoremap("<A-f>", ":FzfLua blines<CR>")
inoremap("<A-f>", "<C-o>:FzfLua blines<CR>")

nnoremap("<C-b>", ":FzfLua buffers<CR>")
inoremap("<C-b>", "<C-o>:FzfLua buffers<CR>")

nnoremap("<C-o>", ":FzfLua lsp_document_symbols<CR>")

nnoremap("<A-d>", ":FzfLua lsp_definitions<CR>")
nnoremap("<A-r>", ":FzfLua lsp_references<CR>")
