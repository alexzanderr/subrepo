local fn = vim.fn

-- plugins folder
-- /home/alexzander/.local/share/nvim/site/pack/packer/start/..
-- or
-- for root
-- /root/.local/share/nvim
--
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    })
    vim.cmd("packadd packer.nvim")
end

local plugins_loader = require("plugins-loader")

return require("packer").startup(function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    -- status line made in lua
    use {
        "hoob3rt/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        disable = not plugins_loader.lualine.enabled
    }

    -- solarized theme made in lua
    use "ishan9299/nvim-solarized-lua"

    -- nvim tree made in lua
    use { "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" }
    -- completion stuff
    use { "hrsh7th/nvim-cmp" }
    -- completion for lua api
    use { "hrsh7th/cmp-nvim-lua" }
    -- -- completion for all opened buffers
    use { "hrsh7th/cmp-buffer" }
    -- -- completion for file system paths
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-nvim-lsp" }
    -- -- have that snippets inside cmp
    use { "saadparwaiz1/cmp_luasnip" }
    -- use { "andersevenrud/compe-tmux", branch = "cmp" }

    -- completion for all languages depending on the LSP
    use {
        "neovim/nvim-lspconfig",
        disable = not plugins_loader.nvim_lspconfig.enabled
    }

    -- LSP install manager
    use { "kabouzeid/nvim-lspinstall" }

    use { "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }

    -- comment line or lines
    use { "terrortylor/nvim-comment" }

    -- a collection of very much quantity of snippets for many langs
    use { "rafamadriz/friendly-snippets" }

    -- brackets auto completion
    use { "windwp/nvim-autopairs" }

    -- snippets engine
    use { "L3MON4D3/LuaSnip" }

    -- telescope
    -- fzf written in lua
    use {
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    }

    -- fzf native
    -- used for fast sorting
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- atom one dark theme in lua
    use { "navarasu/onedark.nvim" }

    -- barbar nvim tab line written in lua
    -- use {
    --     'romgrk/barbar.nvim',
    --     requires = {'kyazdani42/nvim-web-devicons'}
    -- }

    -- project root path management and telescope integration
    use { "ahmedkhalf/project.nvim" }

    -- integrated terminal
    use { "akinsho/toggleterm.nvim" }

    -- nvim colorizer lua, colors the hexa codes and rgbs
    use { "norcalli/nvim-colorizer.lua" }
    -- TODO
    -- dont forget to lazy load plugins for performance
    --
    --
    --
    --
    -- ramane de vazut
    -- use {
    --     'tamago324/nlsp-settings.nvim'
    -- }

    -- use {
    --     'jose-elias-alvarez/null-ls.nvim'
    -- }

    use { "antoinemadec/FixCursorHold.nvim" }

    -- startify made in lua and much better
    use { "glepnir/dashboard-nvim" }

    -- better synatx highlithing
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
        -- branch = "0.5-compat"
    }

    use { "nvim-lua/popup.nvim" }

    -- preview, references, diagnostics
    use { "glepnir/lspsaga.nvim" }

    -- delete extra white space
    use { "cappyzawa/trim.nvim" }

    -- show visual indentation of lines
    use { "lukas-reineke/indent-blankline.nvim", disable = true }

    -- symbols outline
    use { "stevearc/aerial.nvim" }

    -- completion icons
    use { "onsails/lspkind-nvim" }

    -- symbols outline (another one)
    use { "simrat39/symbols-outline.nvim" }

    -- code dark made by chris
    -- use {
    --     'ChristianChiarulli/nvcode-color-schemes.vim'
    -- }

    -- neogit
    -- management for git inside neovim
    use { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }

    -- bufferline.nvim
    -- bufferline is slow on very big project
    -- comparing to barbar
    use { "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" }

    -- a better lsp saga
    -- use {
    --     'RishabhRD/popfix'
    -- }

    -- use {
    --     'RishabhRD/nvim-lsputils'
    -- }

    -- LSP diagnostics, references, definitions, implementation with fzf
    -- use {
    --   'ojroques/nvim-lspfuzzy',
    --   requires = {
    --     {'junegunn/fzf'},
    --     {'junegunn/fzf.vim'},  -- to enable preview (optional)
    --   },
    -- }

    -- lsp colors
    -- errors, warnings, hints and informations
    -- use "folke/lsp-colors.nvim"

    use {
        "ibhagwan/fzf-lua",
        requires = { "vijaymarupudi/nvim-fzf", "kyazdani42/nvim-web-devicons" }, -- optional for icons
        disable = false
    }

    use "sindrets/diffview.nvim"

    -- prettier formatter
    -- use 'lukas-reineke/format.nvim'

    use "mhartington/formatter.nvim"

    -- https://github.com/dstein64/nvim-scrollview/issues/10
    -- this was causing cannot close last window error
    -- use "dstein64/nvim-scrollview"

    use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }

    use { "windwp/nvim-ts-autotag" }

    use { "ray-x/lsp_signature.nvim" }

    use { "mg979/vim-visual-multi", branch = "master" }

    use { "unblevable/quick-scope" }

    use { "kevinhwang91/rnvimr" }

    -- use {
    --     "jbyuki/dash.nvim",
    -- }

    use { "folke/tokyonight.nvim" }

    -- debugger

    use { "jbyuki/one-small-step-for-vimkind" }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use { "theHamsta/nvim-dap-virtual-text" }

    -- use {
    -- 	"alexghergh/nvim-tmux-navigation"
    -- }

    use { "preservim/vimux" }

    use { "nvim-telescope/telescope-symbols.nvim" }

    use { "ThePrimeagen/harpoon" }

    use {
        "nvim-telescope/telescope-frecency.nvim",
        -- config = function()
        --     require"telescope".load_extension("frecency")
        -- end
        requires = { "tami5/sqlite.lua" }
    }

    use "nvim-telescope/telescope-github.nvim"
    use "nvim-telescope/telescope-media-files.nvim"
    -- use "nvim-telescope/telescope-fzf-writer.nvim"
    -- use "jbgutierrez/vim-better-comments"
    --
    use "cljoly/telescope-repo.nvim"
    use "nvim-telescope/telescope-node-modules.nvim"

    use { "AckslD/nvim-neoclip.lua" }

    use "camgraff/telescope-tmux.nvim"

    -- use "nvim-lua/lsp-status.nvim"

    -- use "tjdevries/gruvbuddy.nvim"
    -- use "tjdevries/colorbuddy.vim"

    -- extra rust tools
    use "simrat39/rust-tools.nvim"

    use "akinsho/flutter-tools.nvim"

    use {
        "kevinhwang91/nvim-hlslens"
        -- this is broken
        -- setup = [[vim.g.loaded_nvim_hlslens = 1]],
    }

    use "MunifTanjim/nui.nvim"

    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- use {
    --     "~/Alexzander__/programming/lua/neovim-plugins/nvim-treesitter-statusline"
    -- }
    -- use { "~/Alexzander__/programming/lua/neovim-plugins/testing-lua" }

    -- use {
    -- 	"alexzanderr/nvim-treesitter-statusline",
    -- 	requires = {
    -- 		"nvim-treesitter/nvim-treesitter",
    -- 		"MunifTanjim/nui.nvim",
    -- 	}
    -- }
    --

    use { "SmiteshP/nvim-gps" }

    -- use { "norcalli/snippets.nvim" }

    -- use "b3nj5m1n/kommentary"

    -- use "winston0410/commented.nvim"

    use "arithran/vim-delete-hidden-buffers"

    -- build fails
    -- use {
    -- 	"oknozor/illumination",
    -- 	run = "./install.sh"
    -- }

    -- use 'eddyekofo94/gruvbox-flat.nvim'

    use { "rbtnn/vim-vimscript_indentexpr" }

    -- Lua
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                position = "bottom", -- position of the list can be: bottom, top, left, right
                height = 10, -- height of the trouble list when position is top or bottom
                width = 50, -- width of the list when position is left or right
                icons = true, -- use devicons for filenames
                mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
                fold_open = "", -- icon used for open folds
                fold_closed = "", -- icon used for closed folds
                action_keys = { -- key mappings for actions in the trouble list
                    -- map to {} to remove a mapping, for example:
                    -- close = {},
                    close = "q", -- close the list
                    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                    refresh = "r", -- manually refresh
                    jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
                    open_split = { "<c-x>" }, -- open buffer in new split
                    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
                    open_tab = { "<c-t>" }, -- open buffer in new tab
                    jump_close = { "o" }, -- jump to the diagnostic and close the list
                    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
                    toggle_preview = "P", -- toggle auto_preview
                    hover = "K", -- opens a small popup with the full multiline message
                    preview = "p", -- preview the diagnostic location
                    close_folds = { "zM", "zm" }, -- close all folds
                    open_folds = { "zR", "zr" }, -- open all folds
                    toggle_fold = { "zA", "za" }, -- toggle fold of current file
                    previous = "k", -- preview item
                    next = "j" -- next item
                },
                indent_lines = true, -- add an indent guide below the fold icons
                auto_open = false, -- automatically open the list when you have diagnostics
                auto_close = false, -- automatically close the list when you have no diagnostics
                auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
                auto_fold = false, -- automatically fold a file trouble list at creation
                signs = {
                    -- icons / text used for a diagnostic
                    error = "",
                    warning = "",
                    hint = "",
                    information = "",
                    other = "﫠"
                },
                use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
            }
        end


    }

    -- use { "rmagatti/auto-session" }
    -- use {
    --     "rmagatti/session-lens",
    --     requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    --     config = function()
    --         require("session-lens").setup({
    --             path_display = { "shorten" },
    --             theme_conf = { border = false },
    --             previewer = true,
    --             prompt_title = "your work my buddy"
    --         })
    --     end
    -- }

    use { "p00f/nvim-ts-rainbow" }

    use { "JoosepAlviste/nvim-ts-context-commentstring" }

    use { "romgrk/nvim-treesitter-context" }

    use { "kdheepak/lazygit.nvim" }

    use { "windwp/nvim-spectre" }

    use {
        "nacro90/numb.nvim",
        config = require("numb").setup {
            show_numbers = true, -- Enable 'number' for the window while peeking
            show_cursorline = true, -- Enable 'cursorline' for the window while peeking
            number_only = true -- Peek only when the command is only a number instead of when it starts with a number
        }
    }

    use { "nvim-treesitter/playground" }

    --     use {
    --         "karb94/neoscroll.nvim",
    --         config = function()
    --             require("neoscroll").setup({
    --                 -- All these keys will be mapped to their corresponding default scrolling animation
    --                 -- mappings = {
    --                 --     "<C-u>",
    --                 --     "<C-d>",
    --                 --     "<C-b>",
    --                 --     "<C-f>",
    --                 --     "<C-y>",
    --                 --     "<C-e>",
    --                 --     "zt",
    --                 --     "zz",
    --                 --     "zb"
    --                 -- },
    --                 hide_cursor = true, -- Hide cursor while scrolling
    --                 stop_eof = false, -- Stop at <EOF> when scrolling downwards
    --                 use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    --                 respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    --                 cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    --                 easing_function = nil, -- Default easing function
    --                 pre_hook = nil, -- Function to run before the scrolling animation starts
    --                 post_hook = nil -- Function to run after the scrolling animation ends
    --             })
    --             local t = {}
    --             -- Syntax: t[keys] = {function, {function arguments}}
    --             t["<C-up>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
    --             t["<C-down>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
    --             -- t["<C-b>"] = {
    --             --     "scroll",
    --             --     { "-vim.api.nvim_win_get_height(0)", "true", "450" }
    --             -- }
    --             -- t["<C-f>"] = {
    --             --     "scroll",
    --             --     { "vim.api.nvim_win_get_height(0)", "true", "450" }
    --             -- }
    --             -- t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
    --             -- t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
    --             -- t["zt"] = { "zt", { "250" } }
    --             -- t["zz"] = { "zz", { "250" } }
    --             -- t["zb"] = { "zb", { "250" } }

    --             require("neoscroll.config").set_mappings(t)
    --         end

    --     }

    -- use { "sidebar-nvim/sections-dap" }
    -- use { "sidebar-nvim/sidebar.nvim" }
    -- BUG
    -- https://github.com/folke/todo-comments.nvim/issues/60
    use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }

    use { "mfussenegger/nvim-dap-python" }

    use { "AndrewRadev/tagalong.vim" }

    use { "jubnzv/virtual-types.nvim" }

    use { "RRethy/nvim-treesitter-textsubjects" }

    use { "famiu/nvim-reload" }
    -- mkdir
    use {
        "jghauser/mkdir.nvim",
        config = function() require("mkdir") end


    }

    use { "tjdevries/train.nvim" }

    use { "phaazon/hop.nvim" }

    use { "ekickx/clipboard-image.nvim" }

    -- use { "pwntester/octo.nvim" }

    use { "ThePrimeagen/refactoring.nvim" }

    -- use { "mfussenegger/nvim-ts-hint-textobject" }
    -- use { "yamatsum/nvim-cursorline" }

    --     use {
    --         "sunjon/Shade.nvim",
    --         config = function()
    --             require"shade".setup({
    --                 overlay_opacity = 50,
    --                 opacity_step = 1,
    --                 keys = {
    --                     brightness_up = "<C-Up>",
    --                     brightness_down = "<C-Down>",
    --                     toggle = "<Leader>s"
    --                 }
    --             })

    --         end

    --     }

    -- Is using a standard Neovim install, i.e. built from source or using a
    -- provided appimage.
    use { "lewis6991/impatient.nvim" }
    --
    use { "RishabhRD/nvim-cheat.sh", requires = "RishabhRD/popfix" }

    -- keymap helper
    -- with this you can map lua function to vim keybindings
    -- directly from lua code
    use { "tjdevries/astronauta.nvim" }

    use { "jbyuki/venn.nvim" }

    use { "wsdjeg/vim-fetch" }

    use {
        "glacambre/firenvim",
        run = function() vim.fn["firenvim#install"](0) end


    }
    -- use "Pocco81/AutoSave.nvim"

    use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install" }

    -- use { "ms-jpq/coq_nvim" }

    use {
        "VonHeikemen/fine-cmdline.nvim",
        requires = { { "MunifTanjim/nui.nvim" } }
    }

end
 -- config for packer plugin
-- config = {
-- 	compile_path = vim.fn.stdpath('config')..'init.lua.d/lua/packer_compiled.lua'
-- }
)
