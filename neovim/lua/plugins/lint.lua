local status, lint = pcall(require, "lint")
if not status then
  return
end
-- local path = require("mason-core.path")
-- local registry = require("mason-registry")
--
-- --@param name string
-- local function mason_package(name, opts)
--   if opts == nil then
--     opts = {}
--   end
--   if not registry.is_installed(name) then
--     require("notify")("'" + name + "' is not installed with mason", "error", {
--       title = "Formatter",
--     })
--     return nil
--   end
--   return {
--     exe = path.bin_prefix(name),
--     args = opts.args,
--     stdin = true,
--   }
-- end

lint.linters_by_ft = {
  markdown = { "vale" },
  -- proto = { 'buf_lint', },
}
