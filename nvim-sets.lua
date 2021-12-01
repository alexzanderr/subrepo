-- init.lua contains all of the initialization plugins for vim note;
-- This has to be sourced second since dein needs to run its scripts first.
-- This contains misc startup settings for vim
-- local g = vim.g -- global variable
local set = vim.opt -- set options
local cmd = vim.cmd -- vim command

--  If you want Vim to overrule your settings with the defaults, use
-- cmd("syntax on")
--
cmd("syntax enable")
cmd("filetype indent plugin on")

set.hidden = true
set.title = false
set.background = "dark"
set.termguicolors = true

-- line number
set.number = true
-- no swap files
set.swapfile = false

-- allow unrestricted backspacing in insert mode
set.backspace = "indent,eol,start"
set.mouse = "a"
set.encoding = "utf-8"
set.fileencoding = "utf-8"
set.fileformat = "unix"

set.scrolloff = 8
set.sidescrolloff = 8
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

set.autoindent = true

-- set.colorcolumn = 100
set.cursorline = true

set.signcolumn = "yes"
-- Always show signcolumns

-- set case insensitive search for commands
set.ignorecase = true
set.infercase = true

-- used for making quotes appear in json files and markdown
-- if its set to 2, then quotes will disappear
-- setlocal conceallevel=0
-- but having this to zero, indentLine wont work

-- used for realoding the current file if its modified in other place
set.autoread = true

set.cmdheight = 1

set.shell = "/usr/bin/zsh"

set.backup = false
set.writebackup = false

-- for command line menu
set.compatible = false
set.wildmenu = true
set.wildmode = "full"

set.showmode = false
set.showcmd = false
set.ruler = false
set.laststatus = 2
set.splitright = true
set.foldenable = false
-- goes to the end of line + 1 when pressing <end>
-- set.virtualedit = 'onemore'
set.linebreak = true
set.breakindent = true

-- adding these characters as separators
-- because when you press control+backspace
-- they should not be deleted, but to the stopped at
set.iskeyword = set.iskeyword - "#"
set.iskeyword = set.iskeyword - "_"
set.iskeyword = set.iskeyword - "."
set.iskeyword = set.iskeyword - "/"
-- for css elements
set.iskeyword = set.iskeyword - "-"

-- for better performance
set.viminfo = "'10000,<10000,s10000,h"

-- set to true ss causing scroll flickering
-- https://stackoverflow.com/questions/25170389/flickering-screen-when-scrolling-in-gvim
set.lazyredraw = false


set.regexpengine = 1
set.relativenumber = false
set.synmaxcol = 80

-- this gives error
-- " https://vi.stackexchange.com/questions/5196/how-to-change-the-behavior-of-cursor-motions-ex-go-from-one-line-to-the-end-o

-- https://stackoverflow.com/questions/2574027/automatically-go-to-next-line-in-vim
-- 'whichwrap' 'ww'	string	(Vim default: "b,s", Vi default: "")
-- 			global
-- 	Allow specified keys that move the cursor left/right to move to the
-- 	previous/next line when the cursor is on the first/last character in
-- 	the line.  Concatenate characters to allow this for these keys:
-- 		char   key	  mode	~
-- 		 b    <BS>	 Normal and Visual
-- 		 s    <Space>	 Normal and Visual
-- 		 h    "h"	 Normal and Visual (not recommended)
-- 		 l    "l"	 Normal and Visual (not recommended)
-- 		 <    <Left>	 Normal and Visual
-- 		 >    <Right>	 Normal and Visual
-- 		 ~    "~"	 Normal
-- 		 [    <Left>	 Insert and Replace
-- 		 ]    <Right>	 Insert and Replace
--
set.whichwrap = set.whichwrap + "<,>,h,l,[,]"

set.autochdir = false
-- move to next line and to previous

-- word wrap
set.wrap = true

-- https://github.com/dinhmai74/dotfile-lua/blob/95542e6cc418dd1d995a4d2b4cfb1a82dd1e6733/nvim/lua/init.lua#L37-L46
-- to set vim variables using -= | +=
set.shortmess = set.shortmess + "c"

set.fillchars = set.fillchars + "diff:╱"
-- vim.cmd[[set fillchars+=vert:⎢]]
vim.cmd[[set fillchars+=vert:▊]]
-- set.fillchars = set.fillchars + "vert:⎢"





set.timeoutlen = 100
set.undofile = true




-- https://stackoverflow.com/questions/11890203/set-vim-filetype-for-files-with-no-extension-only
function FileTypeHandler()
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    if filetype == "" then

        -- vim.cmd("set filetype=sh")
        -- print("detected filetype NONE and set to 'sh'")
    end
end

-- 	" Use a blinking upright bar cursor in Insert mode, a blinking block in normal
-- 	if &term == 'xterm-256color' || &term == 'screen-256color'
-- 		let &t_SI = "\<Esc>[5 q"
-- 		let &t_EI = "\<Esc>[1 q"
-- 	endif

-- 	if exists('$TMUX')
-- 		let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
-- 		let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
-- 	endif
-- 	autocmd BufEnter * if (winnr("$") == 1 && (&filetype == 'NvimTree' || &filetype == 'toggleterm')) | q! | endif


-- https://jdhao.github.io/2020/05/22/highlight_yank_region_nvim/
-- highlight yanked text
-- enable tree sitter manually, because somehow it doesnt work just for python
cmd [[
	" autocmd VimEnter * lua FileTypeHandler()
	autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}


	autocmd BufEnter * execute ':TSBufEnable highlight'
	autocmd BufEnter * execute ':TSBufEnable indent'
	autocmd BufEnter * execute ':TSBufEnable rainbow'


	autocmd FileType scss setl iskeyword+=@-@
	autocmd BufRead,BufNewFile *.json set filetype=jsonc






	" autocmd FileType zsh setl filetype=bash

	" docs hover just like vs code
	" autocmd CursorHold * lua vim.lsp.buf.hover()

	" fix indentation of yaml files
	" https://stackoverflow.com/questions/26962999/wrong-indentation-when-editing-yaml-in-vim
	autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab indentkeys-=0# indentkeys-=<:


	" disable tabline (the black line empty) in dashboard
	autocmd FileType dashboard set showtabline=0 | autocmd WinLeave dashboard set showtabline=2

	hi ErrorMsg guifg=#db4b4b
]]

-- ⣿⣿⣿⣿⠟⠉⠄⠄⠄⠄⠄⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣿⣿⡟⠁⠄⠄⠄⠄⠄⢀⠄⠄⠄⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣿⣿⠁⠄⠄⠄⢀⠄⣴⣿⣿⣷⡄⠄⠄⢽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣿⠇⠄⠄⠄⠄⠄⢸⣿⣿⣋⡱⠶⡄⠄⠄⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣿⠂⠄⠄⠄⢀⠁⠄⣺⣿⣿⣴⣷⣿⡀⠄⠱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣏⠄⠄⠄⠄⠄⠄⣴⣿⣿⣿⣿⣿⣿⣧⠄⠄⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣻⡇⠄⠄⠄⠄⠄⢿⣿⣷⠾⡛⢻⣿⠇⠄⢣⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣿⡇⠄⠄⠄⠄⢠⡴⠛⠃⠺⣵⡿⠏⠄⢋⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣻⣧⠄⠄⠄⠄⢾⣧⣖⠷⣦⡀⠄⡦⠄⠈⠉⢛⢟⠿⠿⣿⣿⣿⣿⣿⣿
-- ⣷⠉⠄⠄⠄⠸⣿⣿⡾⠻⣗⠁⠄⠄⣤⣤⣾⡇⠸⡄⠄⠈⣿⣿⣿⣿⣿
-- ⡏⠄⠄⠄⠄⠄⢹⣿⣿⣤⠉⠄⠐⠄⠔⠁⠄⠁⠄⢻⠄⠄⢸⣿⣿⣿⣿
-- ⡄⠄⠄⠄⠄⠄⠄⣿⣿⣿⠄⠄⠄⡖⠄⠄⠄⢀⠄⣼⣶⡀⢸⣿⣿⣿⣿
-- ⣷⡆⠄⠄⠄⠄⣰⣿⣿⠇⠄⣀⠄⠄⠄⠄⣀⣱⣾⣿⡿⠁⢸⣿⣿⣿⣿
-- ⣿⠟⠄⠄⠄⢀⣿⣿⣿⢀⢸⣿⣶⣶⣶⣿⣿⣿⣿⣿⣇⠄⢸⣿⣿⣿⣿
-- ⡇⣶⣶⠄⢀⣾⣿⣿⡟⢨⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠈⣿⣿⣿⣿
-- ⣿⣿⡯⠄⣾⣿⣿⣿⠇⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄⠄⣿⣿⣿⣿
-- ⣿⡿⢏⣼⣿⣿⣿⣟⣤⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠄⠄⢹⣿⣿⣿
--

-- one second
vim.g.cursorhold_updatetime = 1000


-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


-- for itallics
vim.cmd[[
	let &t_ZH="\e[3m"
	let &t_ZR="\e[23m"
]]



-- color column
-- the limit to the right
set.colorcolumn = "81"
