local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

-- lua
saga.setup({
	ui = {
		title = true,
		border = "rounded",
		code_action = "💡",
	},
	preview = {
		lines_below = 30,
		lines_above = 0,
	},
	lightbulb = {
		enable = true,
	},
	finder_icons = {
		def = "  ",
		ref = "諭 ",
		link = "  ",
	},
	outline = {
		win_width = 50,
	},
})
