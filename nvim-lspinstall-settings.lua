-- nvim-lspinstall plugin settings
--
-- plugin url
-- https://github.com/kabouzeid/nvim-lspinstall
-- extra documnentation
-- https://ka.codes/posts/nvim-lspinstall#nvim-lspinstall
vim.cmd [[highlight NormalFloat guibg=#31353f]]
-- vim.cmd [[highlight FloatBorder guibg=#31353f guifg=#BCA633]]
vim.cmd [[highlight FloatBorder guibg=#31353f guifg=fg]]

-- disable diagnostics in insert mode to be more smooth
-- https://github.com/neovim/nvim-lspconfig/issues/127
-- disable diagnostics completely
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
--
--
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- delay update diagnostics
        -- show_diagnostic_autocmds = { 'InsertLeave' }, -- ! error
        update_in_insert = false,
        underline = false,

        -- with this performance is slight better
        -- but it doesnt solve the problem
        virtual_text = false
        -- virtual_text = {
        --     spacing = 7,
        --     prefix = " ■ "
        --     -- language server's name
        --     -- source = "always"
        --     --     -- severity_limit = "Warning",
        -- }
        -- it doesnt do anything
        -- signs = true
    })

_G.border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" }
}

local function on_attach_custom_function()
    -- Error = "#db4b4b",
    -- Warning = "#e0af68",
    -- Information = "#0db9d7",
    -- Hint = "#10B981", "#934491"
    --

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                                                 vim.lsp.handlers.hover,
                                                 { border = border })
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

    vim.fn.sign_define("DiagnosticSignError", {
        text = " ",
        texthl = "DiagnosticSignError",
        numhl = ""
    })
    vim.cmd [[
		hi DiagnosticSignError guifg=#db4b4b
		hi DiagnosticError guifg=#db4b4b
	]]
    vim.fn.sign_define("DiagnosticSignWarn", {
        text = " ",
        texthl = "DiagnosticSignWarn",
        numhl = ""
    })
    vim.cmd [[
		hi DiagnosticSignWarn guifg=#e0af68
		hi DiagnosticWarn guifg=#e0af68
	]]
    vim.fn.sign_define("DiagnosticSignHint", {
        text = " ",
        texthl = "DiagnosticSignHint",
        numhl = ""
    })
    vim.cmd [[
		hi DiagnosticSignHint guifg=#934491
		hi DiagnosticHint guifg=#934491
	]]
    vim.fn.sign_define("DiagnosticSignInfo", {
        text = " ",
        texthl = "DiagnosticSignInfo",
        numhl = ""
    })
    vim.cmd [[
		hi DiagnosticSignInfo guifg=#10B981
		hi DiagnosticInfo guifg=#10B981
	]]

    vim.api.nvim_set_keymap("n", "<A-e>",
                            ":lua vim.lsp.diagnostic.goto_next({popup_opts = {border = border}})<CR>",
                            { noremap = true, silent = true })
    vim.api.nvim_set_keymap("i", "<A-e>",
                            "<c-o>:lua vim.lsp.diagnostic.goto_next({popup_opts = {border = border}})<CR>",
                            { noremap = true, silent = true })

    vim.cmd [[
		nnoremap <A-i> :lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})<CR>
		inoremap <A-i> <c-o>:lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})<CR>


	]]
end


-- -- Capture real implementation of function that sets signs
-- local orig_set_signs = vim.lsp.diagnostic.set_signs
-- local set_signs_limited = function(diagnostics, bufnr, client_id, sign_ns, opts)

--     -- original func runs some checks, which I think is worth doing
--     -- but maybe overkill
--     if not diagnostics then diagnostics = diagnostic_cache[bufnr][client_id] end

--     -- early escape
--     if not diagnostics then return end

--     -- Work out max severity diagnostic per line
--     local max_severity_per_line = {}
--     for _, d in pairs(diagnostics) do
--         if max_severity_per_line[d.range.start.line] then
--             local current_d = max_severity_per_line[d.range.start.line]
--             if d.severity < current_d.severity then
--                 max_severity_per_line[d.range.start.line] = d
--             end
--         else
--             max_severity_per_line[d.range.start.line] = d
--         end
--     end

--     -- map to list
--     local filtered_diagnostics = {}
--     for i, v in pairs(max_severity_per_line) do
--         table.insert(filtered_diagnostics, v)
--     end

--     -- call original function
--     orig_set_signs(filtered_diagnostics, bufnr, client_id, sign_ns, opts)
-- end

-- vim.lsp.diagnostic.set_signs = set_signs_limited

local function automatically_install_missing_servers()
    local installed_servers = require"lspinstall".installed_servers()
    local required_servers = {
        "python",
        "go",
        "html",
        "json",
        "cpp",
        "typescript",
        "yaml",
        "graphql",
        "fortran"
    }
    local at_least_one_new = false
    for _, required_server in pairs(required_servers) do
        local is_server_installed = false

        for _, installed_server in pairs(installed_servers) do

            if required_server == installed_server then
                is_server_installed = true
                break
            end
        end

        if not is_server_installed then
            at_least_one_new = true
            print(required_server .. " is missing ... ")
            print("installing " .. required_server .. " ... ")
            require"lspinstall".install_server(required_server)
        end
    end

    -- if not at_least_one_new then
    -- print("no missing server were installed. everything up to date! :_")
    -- end
end


local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- its working
-- local capabilities = require("coq").lsp_ensure_capabilities(vim.lsp.protocol.make_client_capabilities())

local function setup_servers()
    require"lspinstall".setup()
    local servers = require"lspinstall".installed_servers()

    for _, server in pairs(servers) do
        require"lspconfig"[server].setup {

            -- on_attach = require'virtualtypes'.on_attach,
            on_attach = on_attach_custom_function,
            capabilities = capabilities,
            -- i think this is the delay
            flags = { debounce_text_changes = 2000 },
            settings = {
                gopls = {
                    experimentalPostfixCompletions = true,
                    analyses = { unusedparams = true, shadow = true },
                    staticcheck = true
                },
                ["rust-analyzer"] = {
                    assist = {
                        importGranularity = "module",
                        importPrefix = "by_self"
                    },
                    cargo = { loadOutDirsFromCheck = true },
                    procMacro = { enable = true },
                    workspace = {
                        symbol = { search = { scope = { "workspace" } } }
                    }
                },
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = vim.split(package.path, ";")
                    },
                    completion = { keywordSnippet = "Disable" },
                    -- in case the above one doesnt work
                    -- completion = { keywordSnippet = false },
                    diagnostics = {
                        enable = true,
                        globals = {
                            "use",
                            "vim",
                            "describe",
                            "it",
                            "before_each",
                            "after_each"
                        }
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("/usr/share/nvim/runtime/lua")] = true,
                            [vim.fn.expand(
                                "~/Alexzander__/manjaro-21-xfce/home_folders/Applications__/neovim/src/nvim/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                        }
                    }
                },
                bash = { filetypes = { "sh", "zsh", "bash" } },

                -- in case you need
                -- custom config for /src/app/main.py
                -- https://stackoverflow.com/questions/60820640/how-to-set-a-root-directory-for-pyright
                --
                -- more docs
                -- https://raw.githubusercontent.com/microsoft/pyright/master/docs/configuration.md
                python = {
                    analysis = {
                        extraPaths = {
                            { core = "~/Alexzander__/programming/python3/core" }
                        },
                        autoSearchPaths = false,
                        diagnosticMode = "openFilesOnly",
                        useLibraryCodeForTypes = true,
                        disableOrganizeImports = true,
                        autoImportCompletions = false,
                        typeCheckingMode = { "off" },
                        pythonVersion = "3.9",
                        -- not working
                        reportUnusedImport = "none",

                        -- this is not working
                        exclude = { { "/usr/lib/python3.9/**" } }
                    },
                    -- not working
                    reportUnusedImport = false
                }
            }
        }
    end
end


automatically_install_missing_servers()

setup_servers()

-- automatically setup servers again after `:LspInstall <server>`
require"lspinstall".post_install_hook = function()
    setup_servers() -- makes sure the new server is setup in lspconfig
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end


-- thats why i dont use pyls
-- https://www.reddit.com/r/emacs/comments/ih3q5x/lsp_for_python_sure_but_which_lsp_server/
--
-- because its slow on large projects
