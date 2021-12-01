

vim.cmd[[
" quickscope setttings
" plugin URL
" https://github.com/unblevable/quick-scope
"
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 'b', 'B']

highlight QuickScopePrimary guifg='#4576FF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#77E5B0' gui=underline ctermfg=81 cterm=underline

let g:qs_max_chars=100

" plugin enabled by default
let g:qs_enable=1

" disabled on these buf types
let g:qs_buftype_blacklist = ['terminal', 'nofile']

" disabled on these file types
let g:qs_filetype_blacklist = ['dashboard', 'startify']

let g:qs_delay = 0
]]
