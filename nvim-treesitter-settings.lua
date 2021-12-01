-- nvim-tree-sitter
--
-- plugin url
-- https://github.com/nvim-treesitter/nvim-treesitter
--
--
--
--
--
--
require"nvim-treesitter.configs".setup {
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer"
        }
    },
    playground = {
        enable = false,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?"
        }
    },
    autopairs = { enable = false },
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        -- disable = { "c", "rust" },  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    },
    -- incremental_selection = {
    --     enable = false,
    --     keymaps = {
    --         init_selection = "gnn",
    --         node_incremental = "grn",
    --         scope_incremental = "grc",
    --         node_decremental = "grm"
    --     }
    -- },
    indent = { enable = false },
    autotag = {
        enable = true,
        filetypes = {
            "html",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
            "xml"
        }
    },
    context_commentstring = {
        enable = true,
        config = { css = "// %s" },
        enable_autocmd = false,
        javascript = {
            __default = "// %s",
            jsx_element = "{/* %s */}",
            jsx_fragment = "{/* %s */}",
            jsx_attribute = "// %s",
            comment = "// %s"
        }
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        colors = { -- "#fac863", "#e04e43", "#97e6ae",
			"#e04e43",
			"#565656",
			"#e04e43",
			"#565656",
			"#e04e43",
			"#565656",
		} -- table of hex strings
        -- termcolors = { "red", "yellow" } -- table of colour name strings
    }
    -- nvimGPS = {
    -- 	enable = true
    -- }
}

-- print current location in file using treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/doc/nvim-treesitter.txt
-- line 413

function GetLSPStatus()
    return require("nvim-treesitter").statusline({
        indicator_size = 200,
        separator = " ❱ ",
        transform_fn = function(line)
            return line:gsub("%s*[%[%(%{]*%s*$", "")
        end
,
        -- type_patterns = {'module', 'class', 'function', 'method', 'variable', 'comment', 'number', 'import'}
        -- module is wrong, it prints the file comment in the script
        type_patterns = {
            "class",
            "function",
            "method",
            "import",
            "for",
            "if",
            "while",
            "variable",
            "comment"
        }
    })
end


function PrintLSPStatus() print(GetLSPStatus()) end

