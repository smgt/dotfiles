local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local actions = require("telescope.actions")
local tconfig = require("telescope.config")
local vimgrep_arguments = { unpack(tconfig.values.vimgrep_arguments) }
local trouble = require("trouble.providers.telescope")

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--no-ignore")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

telescope.setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = { height = 0.95 },
		vimgrep_arguments = vimgrep_arguments,
		mappings = {
			i = {
				["<esc>"] = actions.close,
				-- ["<c-t>"] = trouble.open_with_trouble,
			},
			n = {
				-- ["<c->t"] = trouble.open_with_trouble,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "file", "--follow", "--hidden", "--exclude", ".git" },
		},
	},
})

telescope.load_extension("fzy_native")
telescope.load_extension("dap")
