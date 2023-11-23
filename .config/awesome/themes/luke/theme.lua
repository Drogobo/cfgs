---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = os.getenv("HOME") .. "/.config/awesome/themes/luke"

local cairo = require("lgi").cairo
local surface = require("gears.surface")
local gears_color = require("gears.color")

local theme = {}

theme.font          = "Hack 16"

col_gray = "#282a2e"
col_black = "#000000"
col_yellow = "#fefd30"
col_white = "#ffffff"
col_red = "#f2201f"
col_light_red = "#f25554"

theme.bg_normal     = col_gray
theme.bg_focus      = col_yellow
theme.bg_urgent     = col_red
theme.bg_minimize   = col_black
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = col_white
theme.fg_focus      = col_gray
theme.fg_urgent     = col_gray
theme.fg_minimize   = col_white

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(1)
theme.border_normal = col_black
theme.border_focus  = col_yellow
theme.border_marked = col_light_red

theme.systray_icon_spacing = 0
theme.tasklist_disable_icon = true

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(5)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--  taglist_square_size, col_gray
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
-- taglist_square_size, col_white
-- )
local taglist_squares_gap = dpi(2)
local function taglist_squares_sel(size, fg, gap)
    local img = cairo.ImageSurface(cairo.Format.ARGB32, size + gap + 1, size + gap + 1)
    local cr = cairo.Context(img)
    cr:set_source(gears_color(fg))
    cr:set_antialias(cairo.Antialias.NONE)
    cr:rectangle(gap, gap, size + 1, size + 1)
    cr:fill()
    return img
end
local function taglist_squares_unsel(size, fg, gap)
    local img = cairo.ImageSurface(cairo.Format.ARGB32, size + gap + 1, size + gap + 1)
    local cr = cairo.Context(img)
    cr:set_line_width(dpi(1))
    cr:set_antialias(cairo.Antialias.NONE)
    cr:set_source(gears_color(fg))
    cr:rectangle(gap + 1, gap + 1, size, size)
    cr:stroke()
    return img
end

theme.taglist_squares_sel = taglist_squares_sel(taglist_square_size, col_gray, taglist_squares_gap)
theme.taglist_squares_unsel = taglist_squares_unsel(taglist_square_size, col_white, taglist_squares_gap)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."/titlebar/maximized_focus_active.png"

theme.wallpaper = string.format("%s/Pictures/Woods.jpg", os.getenv("HOME"))

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."/layouts/fairhw.png"
theme.layout_fairv = themes_path.."/layouts/fairvw.png"
theme.layout_floating  = themes_path.."/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."/layouts/magnifierw.png"
theme.layout_max = themes_path.."/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."/layouts/tileleftw.png"
theme.layout_tile = themes_path.."/layouts/tilew.png"
theme.layout_tiletop = themes_path.."/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
