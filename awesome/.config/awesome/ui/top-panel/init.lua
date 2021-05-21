local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

configuration = require('configuration.config')
require('widgets.top-panel')

local TopPanel = function(s)

  -- TODO: gap around bar
  -- Wiboxes are much more flexible than wibars simply for the fact that there are no defaults, however if you'd rather have the ease of a wibar you can replace this with the original wibar code
  local panel =
    wibox(
      {
        ontop = true,
        screen = s,
        height = configuration.toppanel_height,
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
        stretch = false,
        bg = beautiful.background,
        fg = beautiful.fg_normal,
        struts = {
          top = configuration.toppanel_height
        }
      }
    )

  panel:struts(
    {
      top = configuration.toppanel_height
    }
  )
  --

  panel:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mypromptbox,
    },
    { -- Middle Widgets
        layout = wibox.layout.fixed.horizontal,
        spacing = beautiful.wibar_spacing,
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      mytextclock,
    },
  }


  return panel
end

return TopPanel

