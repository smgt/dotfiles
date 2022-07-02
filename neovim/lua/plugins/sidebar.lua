local status, sidebar = pcall(require, "sidebar-nvim")
if (not status) then return end

sidebar.setup({
  open = true,
  side = "right",
  sections = { "diagnostics", "todos", "symbols", "git" },
  disable_closing_prompt = true,
  todos = {
    ignored_paths = {'~'}, -- ignore certain paths, this will prevent huge folders like $HOME to hog Neovim with TODO searching
    initially_closed = false, -- whether the groups should be initially closed on start. You can manually open/close groups later.
  },
})
