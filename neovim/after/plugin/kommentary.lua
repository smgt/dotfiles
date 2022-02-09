local status, kommentary = pcall(require, 'kommentary.config')
if (not status) then return end

kommentary.use_extended_mappings()
kommentary.configure_language("terraform", {
  single_line_comment_string = "#",
  multiline_comment_string = {"/*", "*/"},
})
