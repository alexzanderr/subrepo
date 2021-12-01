--
--
--
--
--
--
-- nvim-telescope
--
-- plugin url
-- https://github.com/nvim-telescope/telescope.nvim
--
--
--
--
-- https://github.com/nvim-telescope/telescope-symbols.nvim
--
--
local actions = require("telescope.actions")
-- local telescope_builtin = require("telescope.builtin")

local core = require("core")
local co = core.co

function TelescopeSymbols()
    require("telescope.builtin").symbols {
        sources = { "emoji", "math", "latex", "kaomoji", "gitmoji" }
    }
end


vim.api.nvim_set_keymap("n", "<A-j>", ":lua TelescopeSymbols()<cr>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-j>", co .. ":lua TelescopeSymbols()<cr>",
                        { noremap = true, silent = true })

local previewers = require("telescope.previewers")

-- dont preview files if they are biger than 100000
local dont_preview_big_files = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 100000 then
            return
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end
)
end


-- dont preview binary files and bif files
local Job = require("plenary.job")
local dont_preview_binaries_and_big_files =
    function(filepath, bufnr, opts)
        filepath = vim.fn.expand(filepath)
        Job:new({
            command = "file",
            args = { "--mime-type", "-b", filepath },
            on_exit = function(j)
                local mime_type = vim.split(j:result()[1], "/")[1]
                if mime_type == "text" then
                    vim.loop.fs_stat(filepath, function(_, stat)
                        if not stat then return end
                        if stat.size > 100000 then
                            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
                                "-- file larger than 100000 --"
                            })
                        else
                            previewers.buffer_previewer_maker(filepath, bufnr,
                                                              opts)
                        end
                    end
)

                    -- previewers.buffer_previewer_maker(filepath, bufnr, opts)
                else
                    -- maybe we want to write something to the buffer here
                    vim.schedule(function()
                        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false,
                                                   { "-- binary content --" })
                    end
)
                end
            end


        }):sync()
    end


-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
require("telescope").setup {
    defaults = {
        -- cica with this you can set the filename in the preview window title
        dynamic_preview_title = "andrwe",
        -- still has bugs
        scroll_strategy = "limit",
        -- use_less = true,
        -- selection_strategy = "closest",
        -- sorting_strategy = "ascending",
        -- not working at all
        vimgrep_arguments = {
            "rg",
            "--hidden",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case"
            -- "--colors 'match:fg:169,169,169'"
        },
        border = true,
        file_ignore_patterns = {
            "node_modules",
            ".git",
            ".cache",
            "__pychace__",
            ".pytest_cache",
			"target"
        },
        -- if you want bat for file preview and ripgrep preview
        -- file_previewer = require("telescope.previewers").cat.new,
        -- grep_previewer = require("telescope.previewers").vimgrep.new,

        entry_prefix = "  ",
        selection_caret = "  ",
        -- dont preview files that are bigger than 100000 bytes
        -- buffer_previewer_maker = dont_preview_binaries_and_big_files,
        layout_config = {
            cursor = { width = 0.9999 },
            width = 0.999999999,
            -- width_padding = 0,
            height = 0.99,
            -- preview is set to left
            mirror = true
        },
        layout_strategy = "horizontal",
        -- mirror_layout = { horizontal = true, vertical = false },
        prompt_prefix = "➤  ",
        -- borderchars = { "─", "⎢", "─", "⎢", "╭", "╮", "╯", "╰" },
        -- borderchars = { "─", "⎢", "─", "⎢", " ", " ", " ", " " },
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        mappings = {
            -- make sure you exit telescope using <ESC> and <C-q>
            -- this came out from a reddit post
            -- https://www.reddit.com/r/neovim/comments/ny9pxy/quit_telescope_without_confirmation/
            i = {
                -- close is better that delete buffer
                -- with this when you exit
                ["<esc>"] = actions.close,
                ["<C-q>"] = "delete_buffer",
                ["<C-up>"] = actions.preview_scrolling_up,
                ["<C-down>"] = actions.preview_scrolling_down
                -- ["<C-e>"] = actions.send_to_qflist + actions.open_qflist,
            }
            -- i dont quite use telescope in normal mode
            -- n = {
            --     ["<esc>"] = require("telescope.actions").delete_buffer,
            --     ["<C-q>"] = "delete_buffer"
            --     -- ["<C-e>"] = actions.send_to_qflist + actions.open_qflist,
            -- }
        }
    },
    extensions = {
        -- its super slow
        --         fzf_writer = {
        --             minimum_grep_characters = 2,
        --             minimum_files_characters = 2,
        --
        --             -- Disabled by default.
        --             -- Will probably slow down some aspects of the sorter, but can make color highlights.
        --             -- I will work on this more later.
        --             use_highlighter = true,
        --         },
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg", "pdf", "mp4", "webm" },
            find_cmd = "rg" -- find command (defaults to `fd`)
        },
        fzf = {
            fuzzy = false,
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        -- https://github.com/nvim-telescope/telescope-frecency.nvim
        -- frecency = {
        --     db_root = "/home/alexzander/Alexzander__/manjaro-21-xfce/dotfiles/config_home/nvim/frecency.db.d",
        --     show_scores = true,
        --     show_unindexed = false,
        --     ignore_patterns = {
        --         "*.git/*",
        --         "*/tmp/*",
        --         "*.hg/*",
        --         "*.hglf/*",
        --         "node_modules",
        --         "__pychace__"
        --     },
        --     disable_devicons = false
        --     -- workspaces = {
        --     --     ["conf"] = "/home/alexzander/Alexzander__/.config",
        --     --     ["data"] = "/home/alexzander/Alexzander__/.local/share",
        --     --     ["project"] = "/home/alexzander/Alexzander__/projects",
        --     --     ["wiki"] = "/home/alexzander/Alexzander__/wiki",
        --     -- },
        -- }
    }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:

-- fzf native integrator plugin
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
-- commenting this will improve performance of telescope
--
-- telescope extensions
require("telescope").load_extension("fzf")
-- require("telescope").load_extension("frecency")
require("telescope").load_extension("projects")
require("telescope").load_extension("gh")
require("telescope").load_extension("media_files")
-- require("telescope").load_extension("fzf_writer")
require("telescope").load_extension("repo")
require("telescope").load_extension("neoclip")
-- require("telescope").load_extension("session-lens")
require("telescope").load_extension("node_modules")

-- search for neoclip
vim.api.nvim_set_keymap("n", "<A-c>", ":Telescope neoclip plus<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-c>", "<c-o>:Telescope neoclip plus<CR>",
                        { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader><leader>",
                        "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
                        { noremap = true, silent = true })

-- find files using control + f
local telescope_find_files_command =
    ":lua require\"telescope.builtin\".find_files({ hidden = true })<CR>"
vim.api.nvim_set_keymap("n", "<C-f>", telescope_find_files_command,
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-f>", co .. telescope_find_files_command,
                        { noremap = true, silent = true })

-- find content from all files in current project using shift f
vim.api.nvim_set_keymap("n", "<S-f>", ":Telescope live_grep<CR>",
                        { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<S-f>", "<C-o>:Telescope live_grep<CR>", { noremap = true, silent = true })

-- find in opened buffers
-- vim.api.nvim_set_keymap("n", "<C-b>", ":Telescope buffers<CR>", {
--     noremap = true,
--     silent = true,
-- })
-- vim.api.nvim_set_keymap("i", "<C-b>", "<C-o>:Telescope buffers<CR>", {
--     noremap = true,
--     silent = true,
-- })

-- recent projects
vim.api.nvim_set_keymap("n", "<a-w>", ":Telescope projects<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<a-w>", "<C-o>:Telescope projects<CR>",
                        { noremap = true, silent = true })

-- current file
vim.api.nvim_set_keymap("i", "<A-f>",
                        "<C-o>:Telescope current_buffer_fuzzy_find<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-f>",
                        ":Telescope current_buffer_fuzzy_find<CR>",
                        { noremap = true, silent = true })

-- Telescope lsp_document_diagnostics -> errors and warnings for current file
vim.api.nvim_set_keymap("n", "<C-A-d>",
                        ":Telescope lsp_document_diagnostics<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-A-d>",
                        co .. ":Telescope lsp_document_diagnostics<CR>",
                        { noremap = true, silent = true })

-- Telescope lsp_workspace_diagnostics -> errors and warnings for entire project
vim.api.nvim_set_keymap("n", "<leader>wd",
                        ":Telescope lsp_document_diagnostics<CR>",
                        { noremap = true, silent = true })

-- Telescope lsp_workspace_diagnostics -> errors and warnings for entire project
vim.api.nvim_set_keymap("n", "<A-s>", ":Telescope lsp_document_symbols<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-s>",
                        co .. ":Telescope lsp_document_symbols<CR>",
                        { noremap = true, silent = true })

-- :Telescope lsp_dynamic_workspace_symbols -- symbols in entire workspace (same this as above but for entire project)
vim.api.nvim_set_keymap("n", "<C-A-s>",
                        ":Telescope lsp_dynamic_workspace_symbols<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-A-s>",
                        co .. ":Telescope lsp_dynamic_workspace_symbols<CR>",
                        { noremap = true, silent = true })

-- :Telescope command_history - commands used in vim
vim.api.nvim_set_keymap("n", "<A-h>", ":Telescope command_history<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-h>", co .. ":Telescope command_history<CR>",
                        { noremap = true, silent = true })
-- :Telescope lsp_definitions - source code of functions
vim.api.nvim_set_keymap("n", "<F12>", ":Telescope lsp_definitions<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<F12>", co .. ":Telescope lsp_definitions<CR>",
                        { noremap = true, silent = true })

-- :Telescope lsp_references - multiple instances of the same symbols
vim.api.nvim_set_keymap("n", "<A-r>", ":Telescope lsp_references<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-r>", co .. ":Telescope lsp_references<CR>",
                        { noremap = true, silent = true })

---- very good telescope commands
--
-- Telescope lsp_document_diagnostics -> errors and warnings for current file

-- Telescope lsp_workspace_diagnostics -> errors and warnings for entire project

-- :Telescope current_buffer_fuzzy_find - find content in current file
--
-- :Telescope lsp_document_symbols - current file elements/symbols (variables, classes, functions, methods)
--
-- :Telescope lsp_dynamic_workspace_symbols -- symbols in entire workspace (same this as above but for entire project)
--
-- :Telescope commands - all commands from vim
--
-- :Telescope builtin - telescope's functions
--
-- :Telescope git_files - git in current project, but they dont have git signs
--
-- :Telescope oldfiles - recent accesed files
--
-- Telescope git_commits - obvious
--
-- Telescope grep_string - search just in string in entire project
--
--
-- :Telescope command_history - commands used in vim
--
-- :Telescope colorscheme - obvious
--
--
-- :Telescope lsp_references - multiple instances of the same symbols
--
-- :Telescope lsp_definitions - source code of functions
--
-- :Telescope projects (this is with project.nvim)- recent projects, you select one project and you can search all files in that project
-- :lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.5}})
--
--

-- change colorscheme with beautiful popup
vim.api.nvim_set_keymap("n", "<c-k><c-t>",
                        ":lua require(\"telescope-custom-finders\").change_colorscheme()<cr>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-k><c-t>", co ..
                            ":lua require(\"telescope-custom-finders\").change_colorscheme()<cr>",
                        { noremap = true, silent = true })

-- iterate through opened buffers
vim.api.nvim_set_keymap("n", "<c-b>",
                        ":lua require('telescope.builtin').buffers({entry_maker = require\"telescope-buffers\".gen_from_buffer_like_leaderf()})<cr>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-b>", co ..
                            ":lua require('telescope.builtin').buffers({entry_maker = require\"telescope-buffers\".gen_from_buffer_like_leaderf()})<cr>",
                        { noremap = true, silent = true })

--
--
--
--

vim.cmd("hi TelescopeBorder guifg=none guibg=none ctermfg=none ctermbg=none")
vim.cmd("hi TelescopeMatching guifg=#94D34E")
vim.cmd("hi TelescopeSelection guifg=none guibg=#242424 gui=inverse")
