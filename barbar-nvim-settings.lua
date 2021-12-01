

local map = vim.api.nvim_set_keymap
local noremap_silent = { noremap = true, silent = true }

-- move to left tab
map('n', '<C-pageup>', ':BufferPrevious<CR>', noremap_silent)
map('i', '<C-pageup>', '<C-o>:BufferPrevious<CR>', noremap_silent)
map('v', '<C-pageup>', '<esc>:BufferPrevious<CR>', noremap_silent)
-- move to right tab
map('n', '<C-pagedown>', ':BufferNext<CR>', noremap_silent)
map('i', '<C-pagedown>', '<C-o>:BufferNext<CR>', noremap_silent)
map('v', '<C-pagedown>', '<esc>:BufferNext<CR>', noremap_silent)

-- move tab to left + 1
map('n', '<C-S-pageup>', ':BufferMovePrevious<CR>', noremap_silent)
map('i', '<C-S-pageup>', '<C-o>:BufferMovePrevious<CR>', noremap_silent)
map('v', '<C-S-pageup>', '<esc>:BufferMovePrevious<CR>', noremap_silent)

-- move tab to right + 1
map('n', '<C-S-pagedown>', ':BufferMoveNext<CR>', noremap_silent)
map('i', '<C-S-pagedown>', '<C-o>:BufferMoveNext<CR>', noremap_silent)
map('v', '<C-S-pagedown>', '<esc>:BufferMoveNext<CR>', noremap_silent)

-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', noremap_silent)
map('n', '<A-2>', ':BufferGoto 2<CR>', noremap_silent)
map('n', '<A-3>', ':BufferGoto 3<CR>', noremap_silent)
map('n', '<A-4>', ':BufferGoto 4<CR>', noremap_silent)
map('n', '<A-5>', ':BufferGoto 5<CR>', noremap_silent)
map('n', '<A-6>', ':BufferGoto 6<CR>', noremap_silent)
map('n', '<A-7>', ':BufferGoto 7<CR>', noremap_silent)
map('n', '<A-8>', ':BufferGoto 8<CR>', noremap_silent)
map('n', '<A-9>', ':BufferGoto 9<CR>', noremap_silent)
map('n', '<A-0>', ':BufferLast<CR>', noremap_silent)

-- Close buffer
map('n', '<F25>', ':BufferClose<CR>', noremap_silent)
map('i', '<F25>', '<C-o>:BufferClose<CR>', noremap_silent)
map('v', '<F25>', '<esc>:BufferClose<CR>', noremap_silent)

-- pick buffers just like quick scope plugin
map("n", "<S-a>", ":BufferPick<CR>", noremap_silent)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode


-- close all but current
map("n", "<C-k><C-w>", ":BufferCloseAllButCurrent<CR>", noremap_silent)
map("i", "<C-k><C-w>", "<C-o>:BufferCloseAllButCurrent<CR>", noremap_silent)
map("v", "<C-k><C-w>", "<esc>:BufferCloseAllButCurrent<CR>", noremap_silent)

-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', noremap_silent)
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', noremap_silent)
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', noremap_silent)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used




-- Set barbar's options
vim.g.bufferline = {
  -- Enable/disable animations
  animation = false,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = false,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  -- exclude_ft = ['javascript'],
  -- exclude_name = ['package.json'],

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = true,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 2,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = "unnamed",
}
