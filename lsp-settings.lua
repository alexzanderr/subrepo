-- require "lspconfig".jsonls.setup {
--   cmd = {"vscode-json-language-server", "--stdio"},
--   filetypes = {"json", "jsonc"},
--   init_options = {
--     provideFormatter = false
--   },
--   root_dir = function()
--     return vim.loop.cwd()
--   end
-- }
-- vim.api.nvim_set_keymap("n", "<F12>", ":lua vim.lsp.buf.definition()<CR>", {
--     noremap = true,
--     silent = true,
-- })
--
-- vim.api.nvim_set_keymap("i", "<F12>", "<C-o>:lua vim.lsp.buf.definition()<CR>",
--                         {
--     noremap = true,
--     silent = true,
-- })



-- local lsp_config = require("lspconfig")

-- python language server (pyright)
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#pyright
--
--
-- https://github.com/microsoft/pyright/blob/main/docs/configuration.md
-- local function setup_python_language_server()
-- 	lsp_config.pyright.setup({
-- 		capabilities = require(
-- 			"cmp_nvim_lsp"
-- 		).update_capabilities(
-- 			vim.lsp.protocol.make_client_capabilities()
-- 		),
-- 		flags = {
-- 			debounce_text_changes = 150,
-- 		},
-- 		settings = {
-- 		  python = {
-- 			analysis = {
-- 				extraPaths = {
-- 						{core = "~/Alexzander__/programming/python3/core"}
-- 					},
-- 			  	autoSearchPaths = false,
-- 			  	diagnosticMode = "openFilesOnly",
-- 			  	useLibraryCodeForTypes = true,
-- 			  	disableOrganizeImports = true,
-- 				autoImportCompletions = false,
-- 				typeCheckingMode = {"off"},
-- 				pythonVersion = "3.9",

-- 				-- this is not working
-- 				exclude = {
-- 					{"/usr/lib/python3.9/**"},
-- 				}
-- 			},

-- 		  },
-- 		},
-- 	})
-- end

-- function setup_jedi()
-- 	lsp_config.jedi_language_server.setup{}
-- end

-- setup_jedi()

-- setup_python_language_server()
