--

-- nvim-cmp
--
-- plugin URL
-- https://github.com/hrsh7th/nvim-cmp
--
--
--
--
--
--
-- https://github.com/saadparwaiz1/cmp_luasnip/issues/14
-- for luasnip to work you must to this
-- require("luasnip/loaders/from_vscode").load()
-- all nvim-cmp sub plugins configured in one setup
-- https://github.com/hrsh7th/cmp-nvim-lua
-- https://github.com/hrsh7th/cmp-buffer
-- https://github.com/saadparwaiz1/cmp_luasnip
--
--
--
--
local core = require("core")
local nnoremap = core.nnoremap
local inoremap = core.inoremap

-- it should be local cmp
-- otherwise, mapping will have an error
local cmp = require("cmp")
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')

-- its not working
-- after (|) + enter i get
-- (
--	  | (cursor)
--		)

-- cmp.event:on(
-- 	'confirm_done',
-- 	cmp_autopairs.on_confirm_done
-- 	-- ({
-- 	-- 	map_char = {
-- 	-- 		all="(",
-- 	-- 		tex = '{'
-- 	-- 	}
-- 	-- })
-- )


cmp.setup({
    snippet = {
        expand = function(args) require"luasnip".lsp_expand(args.body) end


    }, -- in this order they will appear in the box
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        -- cmp buffer is causing UI bad performance
        -- so its disabled
        -- { name = "buffer" },

        { name = "path" },
        { name = "nvim_lua" } -- {
        -- 	name = 'tmux',
        -- 	  opts = {
        -- 		all_panes = false,
        -- 		label = '[tmux]',
        -- 		trigger_characters = { '.' },
    }, -- 		trigger_characters_ft = {} -- { filetype = { '.' } }
    -- 	  }
    -- }
    --
    -- this was causing the complete to not open automatically
    -- after the floating window update
    -- completion = {
    --     -- with this false completion is triggered only manually
    --     autocomplete = false
    -- },
    mapping = {
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping.complete(),
        -- ["<C-e>"] = cmp.mapping.close(),
        -- ["<esc>"] = cmp.mapping.close(),
        -- ['<CR>'] = cmp.mapping.confirm({
        --   select = true,
        --   behavior = cmp.ConfirmBehavior.Replace,
        -- }),
        -- ["<CR>"] = function() cmp.mapping.abort() end,
        ["<tab>"] = cmp.mapping.confirm({
            select = true -- behavior = cmp.ConfirmBehavior.Replace,
        })
        -- ["<tab>"] = cmp.mapping.select_next_item(),
    },
    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
                                " " .. vim_item.kind

            -- set a name for each source
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                buffer = "[Buffer]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
                -- https://github.com/andersevenrud/compe-tmux/issues/6
                tmux = "[tmux]"
            })[entry.source.name]
            return vim_item
        end


    }
})

-- up and down over long lines
-- used for long line traversing
-- normal mode
nnoremap { "<Up>", "gk" }
nnoremap { "<Down>", "gj" }

-- insert mode
-- inoremap { "<Down>", "pumvisible() ? \"<Down>\" : \"<C-O>gj\"", expr = true }
-- inoremap { "<Up>", "pumvisible() ? \"<Up>\" : \"<C-O>gk\"", expr = true }
-- inoremap_expr("<CR>",  "pumvisible() ? \"<c-e><cr>\" : \"<CR>\"")
-- inoremap_expr("<tab>",  "pumvisible() ? \"<Return>\" : \"<tab>\"")

vim.cmd(
    "autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }")

-- color the thumb of the scrollbar of the completion menu
-- vim.cmd('highlight PmenuThumb guibg=#f73e3e gui=bold')
-- vim.cmd("highlight PmenuThumb guibg=#F55138 gui=bold")
vim.cmd [[
	" scrollbar
	highlight PmenuThumb guibg=#e86671 gui=bold

	" menu selection when you use arrows
	hi PmenuSel guibg=#e86671

	" fuzzy match for what you typed
	hi CmpItemAbbrMatchFuzzy guifg=#4695DFa

	" matched item (what you typed until present)
	hi CmpItemAbbrMatch guifg=#e86671

	" [LSP] section
 	hi CmpItemMenu guifg=#61afef

	" uncompleted item that may be good for completion
	" hi CmpItemAbbr guifg=#808080
	hi CmpItemAbbr guifg=#9C9C9C
]]


