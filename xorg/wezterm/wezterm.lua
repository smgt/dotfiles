local wezterm = require 'wezterm';

-- A helper function for my fallback fonts
function font_with_fallback(name, params)
  -- local names = {name, "Noto Color Emoji", "JetBrains Mono"}
  local names = {name, "Noto Color Emoji", "FiraCode Nerd Font"}
  return wezterm.font_with_fallback(names, params)
end

function font_victor_mono()
  local font = font_with_fallback("VictorMono Nerd Font", {weight="Bold"})
  local rules = {
    -- Select a fancy italic font for italic text
    {
      italic = true,
      font = font_with_fallback("VictorMono Nerd Font", {weight="Bold", italic=true}),
    },

    -- Similarly, a fancy bold+italic font
    {
      italic = true,
      intensity = "Bold",
      font = font_with_fallback("VictorMono Nerd Font", {weight="DemiBold", italic=true}),
    },

    -- Make regular bold text a different color to make it stand out even more
    {
      -- <= <=> == != i k y
      intensity = "Bold",
      font = font_with_fallback("VictorMono Nerd Font", {weight="DemiBold"}),
    },

    --[[ For half-intensity text, use a lighter weight font
    {
      intensity = "Half",
      font = font_with_fallback("Operator Mono SSm Lig Light"),
    }, ]]
  }
  return rules
end

function FontIosevka(opts)
  local family = "Iosevka Term Curly"

  local features = {"calt=0", "dlig=1", "clig=1"}
  local italic_features = features

  opts.font = font_with_fallback({
    family=family,
    harfbuzz_features=features,
  })

  opts.font_rules = {
    -- Italic
    {
      italic = true,
      intensity = "Normal",
      font = wezterm.font({
        family=family,
        weight="Regular",
        italic=true,
        harfbuzz_features=italic_features,
      }),
    },
    -- Italic + bold
    {
      italic = true,
      intensity = "Bold",
      font = wezterm.font({
        family=family,
        weight="Bold",
        italic=true,
        harfbuzz_features=features,
      }),
    },
    -- Bold
    {
      intensity = "Bold",
      font = wezterm.font({
        family=family,
        weight="Bold",
        harfbuzz_features=features,
      }),
    },
    -- Half
    {
      intensity = "Half",
      font = wezterm.font({
        family=family,
        weight="ExtraLight",
        harfbuzz_features=features,
      }),
    },
  }
  return opts
end

return FontIosevka({
  -- font = wezterm.font("JetBrainsMono Nerd Font"),
  -- font = wezterm.font("VictorMono Nerd Font", {italic=false}),

  font_size = 10.0,
  enable_tab_bar = false,
  color_scheme_dirs = {"$HOME/.config/wezterm/colors"},
  color_scheme = "tokyonight-storm",
  force_reverse_video_cursor = true,
  -- Kanagawa
  -- colors = {
  --   foreground = "#dcd7ba",
  --   background = "#1f1f28",

  --   cursor_bg = "#c8c093",
  --   cursor_fg = "#c8c093",
  --   cursor_border = "#c8c093",

  --   selection_fg = "#c8c093",
  --   selection_bg = "#2d4f67",

  --   scrollbar_thumb = "#16161d",
  --   split = "#16161d",

  --   ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
  --   brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
  --   indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
  -- },

  ssh_domains = {
    {
      name = "grunte",
      remote_address = "grunte",
    }
  },
})
