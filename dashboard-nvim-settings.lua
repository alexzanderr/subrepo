-- require("dashboard_nvim").setup{}
-- " Default value is clap
vim.g.dashboard_default_executive ='telescope'
-- https://github.com/glepnir/dashboard-nvim/wiki/Ascii-Header-Text
vim.g.dashboard_custom_header = {
    "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗  ⣿⣿⣿⣿⠟⠉⠄⠄⠄⠄⠄⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║  ⣿⣿⡟⠁⠄⠄⠄⠄⠄⢀⠄⠄⠄⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║  ⣿⣿⠁⠄⠄⠄⢀⠄⣴⣿⣿⣷⡄⠄⠄⢽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║  ⣿⠇⠄⠄⠄⠄⠄⢸⣿⣿⣋⡱⠶⡄⠄⠄⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║  ⣿⠂⠄⠄⠄⢀⠁⠄⣺⣿⣿⣴⣷⣿⡀⠄⠱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝  ⣏⠄⠄⠄⠄⠄⠄⣴⣿⣿⣿⣿⣿⣿⣧⠄⠄⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "                                                        ⣻⡇⠄⠄⠄⠄⠄⢿⣿⣷⠾⡛⢻⣿⠇⠄⢣⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "                                                        ⣿⡇⠄⠄⠄⠄⢠⡴⠛⠃⠺⣵⡿⠏⠄⢋⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "                                                        ⣻⣧⠄⠄⠄⠄⢾⣧⣖⠷⣦⡀⠄⡦⠄⠈⠉⢛⢟⠿⠿⣿⣿⣿⣿⣿⣿",
    "                                                        ⣷⠉⠄⠄⠄⠸⣿⣿⡾⠻⣗⠁⠄⠄⣤⣤⣾⡇⠸⡄⠄⠈⣿⣿⣿⣿⣿",
    "                                                        ⡏⠄⠄⠄⠄⠄⢹⣿⣿⣤⠉⠄⠐⠄⠔⠁⠄⠁⠄⢻⠄⠄⢸⣿⣿⣿⣿",
    "                                                        ⡄⠄⠄⠄⠄⠄⠄⣿⣿⣿⠄⠄⠄⡖⠄⠄⠄⢀⠄⣼⣶⡀⢸⣿⣿⣿⣿",
    "                                                        ⣷⡆⠄⠄⠄⠄⣰⣿⣿⠇⠄⣀⠄⠄⠄⠄⣀⣱⣾⣿⡿⠁⢸⣿⣿⣿⣿",
    "                                                        ⣿⠟⠄⠄⠄⢀⣿⣿⣿⢀⢸⣿⣶⣶⣶⣿⣿⣿⣿⣿⣇⠄⢸⣿⣿⣿⣿",
    "                                                        ⡇⣶⣶⠄⢀⣾⣿⣿⡟⢨⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠈⣿⣿⣿⣿",
    "                                                        ⣿⣿⡯⠄⣾⣿⣿⣿⠇⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄⠄⣿⣿⣿⣿",
    "                                                        ⣿⡿⢏⣼⣿⣿⣿⣟⣤⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠄⠄⢹⣿⣿⣿"
}

vim.g.dashboard_custom_footer = { "neovim loaded " .. #vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1) .. " plugins" }


function GetUnExpanedCWD()
	local cwd = vim.fn.getcwd()
	local splitted = StringSplit(cwd, "/")
	local unexpaned_cwd = "~/"
	for i = 3, #splitted do
		unexpaned_cwd = unexpaned_cwd .. splitted[i] .. "/"
	end
	return unexpaned_cwd
end


vim.g.dashboard_custom_section = {
    a = {
        description = { "  sessions search (workspaces)" },
        command = "Telescope session-lens search_session"
    },
    b = {
        description = { "ﭯ  recent files (mru)" },
        command = "lua require('telescope').extensions.frecency.frecency()"
    },
    c = {
        description = { "  find files at cwd (" .. GetUnExpanedCWD() .. ")" },
        command = "Telescope find_files"
    },
    d = {
		description = {"  new file at cwd (" .. GetUnExpanedCWD() .. ")"},
		command = "lua CreateNewFile()"
	},
	e = {
		description = {"  change colorscheme"},
		command = "lua require(\"telescope-custom-finders\").change_colorscheme()"
	},
	f = {
		description = {"  find word"},
		command = "Telescope live_grep"
	},
	g = {
		description = {" recent projects "},
		command = "Telescope projects"
	}
}

