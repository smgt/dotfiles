local wezterm = require 'wezterm';

-- A helper function for my fallback fonts
function font_with_fallback(name, params)
  -- local names = {name, "Noto Color Emoji", "JetBrains Mono"}
  local names = {name, "Noto Color Emoji", "Anonymice Nerd Font"}
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

function font_iosevka()
  local family = "Iosevka Term Curly"
  local features = {"calt=1", "dlig=1", "cv36=4"}
  local italic_features = features
  local rules = {
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
  return rules
end

return {
  -- font = wezterm.font("JetBrainsMono Nerd Font"),
  -- font = wezterm.font("VictorMono Nerd Font", {italic=false}),
  font = font_with_fallback({
    family="Iosevka Term Curly",
    harfbuzz_features={"calt=1", "clig=1", "dlig=1"},
  }),
  font_rules = font_iosevka(),

  font_size = 10.0,
  enable_tab_bar = false,
  color_scheme_dirs = {"$HOME/.config/wezterm/colors"},
  color_scheme = "tokyonight-storm",

  ssh_domains = {
    {
      name = "grunte",
      remote_address = "grunte",
    }
  },
}
