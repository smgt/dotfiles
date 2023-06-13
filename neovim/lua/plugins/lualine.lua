local status, lualine = pcall(require, "lualine")
if not status then
  return
end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "tokyonight",
    section_separators = { left = "", right = "" },
    component_separators = { left = "🭲", right = "🭲" },
    disabled_filetypes = {
      "dapui_breakpoints",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_repl",
      "dapui_watches",
    },
  },
  winbar = {},
  inactive_winbar = {},
  sections = {
    lualine_a = {
      { "mode" },
    },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1,       -- 0 = just filename, 1 = relative path, 2 = absolute path
        symbols = {
          modified = "[+]",
          readonly = "[-]",
          unnamed = "[No Name]",
        },
      },
      {
        "diff",
        colored = true, -- Displays a colored diff status if set to true
        diff_color = {
          -- Same color values as the general color option can be used here.
          added = "DiffAdd",                                  -- Changes the diff's added color
          modified = "DiffChange",                            -- Changes the diff's modified color
          removed = "DiffDelete",                             -- Changes the diff's removed color you
        },
        symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
        source = nil,                                         -- A function that works as a data source for diff.
        -- It must return a table as such:
        --   { added = add_count, modified = modified_count, removed = removed_count }
        -- or nil on failure. count <= 0 won't be displayed.
      },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_lsp" },
        sections = { "error", "warn", "info", "hint" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        colored = true,
      },
      "encoding",
      {
        "fileformat",
        symbols = {
          unix = "", -- e712
          dos = "", -- e70f
          mac = "", -- e711
        },
      },
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1,       -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "fugitive" },
})
