local wezterm = require("wezterm")
local os = require("os")

local M = {}

function M.apply_to_config(config)
    -- Appearance & Performance
    config.front_end = "WebGpu" -- Recommended: Better performance
    config.check_for_updates = false
    config.use_ime = true
    config.warn_about_missing_glyphs = false
    config.animation_fps = 60 -- Recommended: Smoother animations (Original was 1)
    -- config.animation_fps = 1
    
    config.cursor_blink_rate = 800 -- Recommended: standard blinking (Original was 0)
    config.cursor_blink_ease_in = "EaseIn"
    config.cursor_blink_ease_out = "EaseOut"
    -- config.cursor_blink_ease_in = "Constant"
    -- config.cursor_blink_ease_out = "Constant"
    -- config.cursor_blink_rate = 0

    config.scrollback_lines = 10000 -- Recommended (Original was 3500)
    -- config.scrollback_lines = 3500

    -- Window / Tab Bar
    config.enable_tab_bar = true
    -- config.enable_tab_bar = false
    config.use_fancy_tab_bar = false
    config.tab_bar_at_bottom = false
    -- config.window_decorations = "NONE"
    
    config.window_padding = {
        left = "1cell",
        right = "1cell",
        top = "0.5cell",
        bottom = "0.5cell",
    }
    -- config.window_padding = { left = 0, right = 0, top = 0, bottom = 20 }
    
    config.adjust_window_size_when_changing_font_size = true
    config.enable_scroll_bar = false
    config.enable_wayland = false
    
    -- Font
    config.font_size = 12.0 -- Recommended
    -- config.font_size = 10.5
    -- config.font_size = 11.5
    -- config.font_size = 11
    -- config.font_size = 10
    -- config.font_size = 9.5
    
    config.font = wezterm.font_with_fallback({
        "JetBrains Mono",
        "Noto Color Emoji",
    })
    -- config.font = wezterm.font("HackGenNerdConsole")
    -- config.font = wezterm.font("UDEVGothicLG", { weight = "Regular", italic = false })
    -- config.freetype_load_target = "Normal"
    -- config.font_antialias = "Subpixel"
    
    -- Color Scheme
    config.color_scheme = "Sonokai (Gogh)"
    -- config.color_scheme = 'Red Scheme'
    config.color_scheme_dirs = { os.getenv("HOME") .. "/.config/wezterm/colors/" }
    
    -- Cursor Style
    config.default_cursor_style = "SteadyBar"
    -- config.default_cursor_style = "SteadyUnderline"

    -- Colors (Original manual overrides)
    -- config.colors = {
    --     foreground = "white",
    --     background = "black",
    --     cursor_fg = "black",
    --     cursor_bg = "AZURE",
    --     cursor_border = "AZURE",
    --     selection_fg = "black",
    --     selection_bg = "pink",
    --     split = "#444444",
    --     ansi = { "#000000", "DEEPPINK", "#FE5FD6", "#F0E68C", "GREENYELLOW", "#8ABEB7", "#8ABEB7", "#C0C0C0" },
    --     brights = { "#808080", "#C3C3BE", "#F85ED2", "#FFFF00", "#7EA1BB", "#B294BB", "#B0E0E6", "white" },
    --     compose_cursor = "POWDERBLUE",
    --     tab_bar = { inactive_tab_edge = "#575757" },
    -- }

    -- Hyperlink Rules
    config.hyperlink_rules = wezterm.default_hyperlink_rules()
    -- Custom GitHub rule
    table.insert(config.hyperlink_rules, {
        regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
        format = "https://www.github.com/$1/$3",
    })
    -- All previous hyperlink rules should be preserved here if needed, 
    -- but wezterm.default_hyperlink_rules() covers most.
end

return M
