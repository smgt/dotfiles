local status, lint = pcall(require, 'lint')
if (not status) then return end

lint.linters_by_ft = {
  markdown = { 'vale', },
  -- proto = { 'buf_lint', },
}
