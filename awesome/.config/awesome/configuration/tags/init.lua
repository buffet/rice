local awful = require('awful')
local gears = require('gears')
-- local icons = require('theme.icons')
local apps = require('configuration.apps')

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile.left,
  awful.layout.suit.corner.ne,
}
-- }}}

-- Configure Tag Properties
awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
end)
-- }}}

