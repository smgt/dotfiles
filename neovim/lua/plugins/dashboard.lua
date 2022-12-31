local status, db = pcall(require, "dashboard")
if not status then
	return
end

local dashboard_custom_header = {
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}
local dch1 = {
	"   ██████   █████                                ███                 ",
	"░░██████ ░░███                                ░░░                  ",
	" ░███░███ ░███   ██████   ██████  █████ █████ ████  █████████████  ",
	" ░███░░███░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███ ",
	" ░███ ░░██████ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███ ",
	" ░███  ░░█████ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███ ",
	" █████  ░░█████░░██████ ░░██████   ░░█████    █████ █████░███ █████",
	"░░░░░    ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ ",
}
local home = os.getenv("HOME")
db.custom_header = dch1
db.custom_center = {
	{ icon = " ", desc = "Find File            ", action = "Telescope find_files", shortcut = ",p" },
	{ icon = " ", desc = "New File              ", action = "DashboardNewFile" },
	{ icon = " ", desc = "File Browser           ", action = "NvimTreeOpen" },
	{
		icon = " ",
		desc = "Find word            ",
		action = "Telescope live_grep",
		shortcut = ",l",
	},
	{
		icon = " ",
		desc = "Open dotfiles         ",
		action = "Telescope dotfiles path=" .. home .. "/.dotfiles",
	},
	{
		icon = "  ",
		desc = "Mason Package Manager",
		action = "Mason",
		shortcut = "M",
	},
}
