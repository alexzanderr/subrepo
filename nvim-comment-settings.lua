-- nvim-comment
--
-- plugin url
-- https://github.com/terrortylor/nvim-comment
require("nvim_comment").setup({
    -- Linters prefer comment and line to have a space in between markers
    marker_padding = true,
    -- should comment out empty or whitespace only lines
    comment_empty = false,
    -- Should key mappings be created
    create_mappings = true,
    -- Normal mode mapping left hand side
    line_mapping = "gcc",
    -- Visual/Operator mapping left hand side
    operator_mapping = "gc",
    -- Hook function to call before commenting takes place
    hook = function()
        require("ts_context_commentstring.internal").update_commentstring()
    end

})

-- comment line in normal mode
vim.api.nvim_set_keymap("n", "<C-_>", ":CommentToggle<CR>",
                        { noremap = true, silent = true })

-- comment line or lines in visual mode
vim.api.nvim_set_keymap("v", "<C-_>", ":CommentToggle<CR>gv",
                        { noremap = true, silent = true })
-- notice that there is 'gv' after the CommentToggle command
-- this because we want to select everything back after commeting

-- comment line in insert mode
vim.api.nvim_set_keymap("i", "<C-_>", "<C-o>:CommentToggle<CR>",
                        { noremap = true, silent = true })
