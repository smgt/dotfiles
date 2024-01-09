local status, lint = pcall(require, "lint")
if not status then
  return
end
local path = require("mason-core.path")
local registry = require("mason-registry")
local function mason_package(name, opts)
  if opts == nil then
    opts = {}
  end
  if not registry.is_installed(name) then
    require("notify")("'" .. name .. "' is not installed with mason", "error", {
      title = "Lint",
    })
    return nil
  end
  return function()
    if opts.callback then
      opts.callback(opts)
    end
    return {
      exe = path.bin_prefix(name),
      args = opts.args,
      stdin = true,
    }
  end
end

require("lint").linters.protolint = {
  cmd = mason_package("protolint"),
  stdin = true,           -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
  append_fname = true,    -- Automatically append the file name to `args` if `stdin = false` (default: true)
  args = {},              -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
  stream = nil,           -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
  ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
  env = nil,              -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
  parser = function(output)
    return {}
  end,
}

lint.linters_by_ft = {
  markdown = { "vale" },
  proto = { "buf_lint" },
}
