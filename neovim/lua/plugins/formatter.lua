-- Utilities for creating configurations
local util = require("formatter.util")
local path = require("mason-core.path")
local registry = require("mason-registry")

--@param name string
local function mason_package(name, opts)
  if opts == nil then
    opts = {}
  end
  if not registry.is_installed(name) then
    require("notify")("'" + name + "' is not installed with mason", "error", {
      title = "Formatter",
    })
    return nil
  end
  return {
    exe = path.bin_prefix(name),
    args = opts.args,
    stdin = true,
  }
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.DEBUG,
  -- All formatter configurations are opt-in
  filetype = {
    go = {
      mason_package("goimports"),
      mason_package("golines"),
    },
    lua = {
      mason_package("stylua", {
        args = {
          "--search-parent-directories",
          "--stdin-filepath",
          util.escape_path(util.get_current_buffer_file_path()),
          "--",
          "-",
        },
      }),
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
})
