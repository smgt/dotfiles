require("dap-go").setup()
local dap = require("dap")
local dapui = require("dapui")
-- local widgets = require('dap.ui.widgets')

dapui.setup({
	icons = { expanded = "", collapsed = "", current_frame = "" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
	},
	-- Expand lines larger than the window
	-- Requires >= 0.7
	expand_lines = vim.fn.has("nvim-0.7") == 1,
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.25,
			position = "bottom",
		},
	},
	controls = {
		-- Requires Neovim nightly (or 0.8 when released)
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "",
			terminate = "",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
		max_value_lines = 100, -- Can be integer or nil.
	},
})

-- Open dap-ui when a new session is started
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

-- Close dap-ui when a session is terminated
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

-- Close dap-ui when a session is over
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- buf_set_keymap('n', '<leader>B',  '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
-- buf_set_keymap('n', '<leader>lp',  '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
-- buf_set_keymap('n', '<leader>dr',  '<cmd>lua require"dap".repl.open()<CR>', opts)
-- buf_set_keymap('n', '<leader>dl',  '<cmd>lua require"dap".run_last()<CR>', opts)
-- <F5><F4><F3><F2>
dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	-- works with go.mod packages and sub packages
	{
		type = "go",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

-- dap.adapters.go = {
-- 	type = "server",
-- 	host = "127.0.0.1",
-- 	port = 38697,
-- }
