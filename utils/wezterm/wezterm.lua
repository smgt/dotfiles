local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local mux_servers = { "grunte", "paprika", "sugarsnap" }

-- Generate unix domain config for all mux_servers
local function gen_unix_domains()
  local c = {}
  for i, v in ipairs(mux_servers) do
    c[i] = {
      name = v,
      proxy_command = { "ssh", v, "wezterm", "cli", "proxy" },
    }
  end
  return c
end

-- Define themes for dark/light mode and default fallback
local function scheme_for_appearance(appearance)
  wezterm.log_info(appearance)
  if appearance == nil then
    -- return "Catppuccin Frappe"
    return "Tokyo Night Moon"
  end
  if appearance:find("Light") then
    -- return "Catppuccin Latte"
    return "Tokyo Night Moon"
  else
    -- return "Catppuccin Frappe"
    return "Tokyo Night Moon"
  end
end

-- Action on local machine
wezterm.on("gui-startup", function(cmd)
  local args = {}
  if cmd then
    args = cmd.args
  end

  local _, _, window = mux.spawn_window({
    workspace = "local",
    args = args,
  })
  -- window:spawn_tab({})
  -- spawn 10 tabs
  -- for _ = 1, 10 do
  --   window:spawn_tab {}
  -- end

  mux.set_active_workspace("local")
end)

-- Action on mux server
wezterm.on("mux-startup", function()
  local _, _, window = mux.spawn_window({
    workspace = wezterm.hostname(),
  })
  -- Spawn n mux tabs (on dev server)
  for _ = 1, 2 do
    window:spawn_tab({})
  end
end)

-- A helper function for my fallback fonts
function font_with_fallback(name, params)
  -- local names = {name, "Noto Color Emoji", "JetBrains Mono"}
  local names = { name, "Symbols Nerd Font", "Noto Color Emoji", "JetBrains Mono" }
  return wezterm.font_with_fallback(names, params)
end

function font_jetbrains(opts)
  local family = "JetBrainsMono Nerd Font"

  opts.font = font_with_fallback({
    family = family,
  })
  return opts
end

function font_firacode(opts)
  local family = "FiraCode Nerd Font Mono Ret"

  opts.font = font_with_fallback({
    family = family,
  })
  return opts
end

function font_victor_mono()
  local font = font_with_fallback("VictorMono Nerd Font", { weight = "Bold" })
  local rules = {
    -- Select a fancy italic font for italic text
    {
      italic = true,
      font = font_with_fallback("VictorMono Nerd Font", { weight = "Bold", italic = true }),
    },

    -- Similarly, a fancy bold+italic font
    {
      italic = true,
      intensity = "Bold",
      font = font_with_fallback("VictorMono Nerd Font", { weight = "DemiBold", italic = true }),
    },

    -- Make regular bold text a different color to make it stand out even more
    {
      -- <= <=> == != i k y
      intensity = "Bold",
      font = font_with_fallback("VictorMono Nerd Font", { weight = "DemiBold" }),
    },

    --[[ For half-intensity text, use a lighter weight font
    {
      intensity = "Half",
      font = font_with_fallback("Operator Mono SSm Lig Light"),
    }, ]]
  }
  return rules
end

-- if
function font_iosevka(opts)
  -- local family = "Iosevka Nerd Font"
  local family = "Iosevka Term Curly"

  local features = { "calt=0", "dlig=1", "clig=1" }
  local italic_features = features

  opts.font = font_with_fallback({
    family = family,
    harfbuzz_features = features,
  })

  opts.font_rules = {
    -- Italic
    {
      italic = true,
      intensity = "Normal",
      font = wezterm.font({
        family = family,
        weight = "Light",
        italic = true,
        harfbuzz_features = italic_features,
      }),
    },
    -- Italic + bold
    {
      italic = true,
      intensity = "Bold",
      font = wezterm.font({
        family = family,
        weight = "Regular",
        italic = true,
        harfbuzz_features = features,
      }),
    },
    -- Bold
    {
      intensity = "Bold",
      font = wezterm.font({
        family = family,
        weight = "Bold",
        harfbuzz_features = features,
      }),
    },
    -- Half
    {
      intensity = "Half",
      font = wezterm.font({
        family = family,
        weight = "ExtraLight",
        harfbuzz_features = features,
      }),
    },
  }
  return opts
end

local settings = font_iosevka({
  font_size = 10.0,
  -- leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1001 },
  -- keys = {
  -- 	{ key = "1", mods = "LEADER", action = act({ ActivateTab = 0 }) },
  -- 	{ key = "2", mods = "LEADER", action = act({ ActivateTab = 1 }) },
  -- 	{ key = "3", mods = "LEADER", action = act({ ActivateTab = 2 }) },
  -- 	{ key = "4", mods = "LEADER", action = act({ ActivateTab = 3 }) },
  -- 	{ key = "5", mods = "LEADER", action = act({ ActivateTab = 4 }) },
  -- 	{ key = "6", mods = "LEADER", action = act({ ActivateTab = 5 }) },
  -- 	{ key = "h", mods = "LEADER", action = act.SplitHorizontal },
  -- 	{ key = "v", mods = "LEADER", action = act.SplitVertical },
  -- 	{
  -- 		key = "Backspace",
  -- 		mods = "LEADER",
  -- 		action = act.ShowLauncherArgs({
  -- 			flags = "FUZZY|WORKSPACES",
  -- 		}),
  -- 	},
  -- 	-- { key = "b", mods = "LEADER|CTRL", action = act.SendString("\x01") },
  -- },
  color_scheme_dirs = { "$HOME/.config/wezterm/colors" },
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  force_reverse_video_cursor = true,
  warn_about_missing_glyphs = false,
  exit_behavior = "Close",

  enable_wayland = true,

  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  -- use_fancy_tab_bar = true,
  tab_bar_at_bottom = false,
  unix_domains = gen_unix_domains(),
  window_padding = {
    left = 0,
    right = 0,
    bottom = 0,
    top = 0,
  },
})

-- custom hyperlink rules
settings.hyperlink_rules = wezterm.default_hyperlink_rules() -- insert default rules

-- make task numbers clickable
-- the first matched regex group is captured in $1.
table.insert(settings.hyperlink_rules, {
  regex = [[\b((?:CP|CONALL)-\d+)\b]],
  format = "https://readly.atlassian.net/browse/$1",
})

return settings
