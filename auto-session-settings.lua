
vim.o.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
-- vim.g.auto_session_pre_save_cmds = {"tabdo NvimTreeClose", "tabdo SymbolsOutlineClose", "tabdo ToggleTermCloseAll"}

function CustomCloseHook()
	vim.cmd("NvimTreeClose")
	vim.cmd("SymbolsOutlineClose")
	vim.cmd("ToggleTermCloseAll")
end

local opts = {
    log_level = "info",
    auto_session_enable_last_session = false,
	-- default is ~/.config/nvim/sessions
    auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_session_enabled = false,
    auto_save_enabled = true,
    auto_restore_enabled = nil,
    auto_session_suppress_dirs = nil,
	auto_session_pre_save_cmds = {
		CustomCloseHook
	}
}

require("auto-session").setup(opts)
