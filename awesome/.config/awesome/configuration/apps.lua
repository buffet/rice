local dpi = require("beautiful.xresources").apply_dpi
local menubar = require("menubar")

apps = {

  -- Your default terminal
  terminal        = "alacritty",

  -- Your default text editor
  editor          = os.getenv("EDITOR") or "vim",

  -- editor_cmd = terminal .. " -e " .. editor,

  -- Your default browser
  browser         = "chromium",

  -- Your default screenshot tool
  screenshot      = "flameshot gui",

  -- Screenlocker
  -- screenlocker    = "i3lock -ec '#f5efdc'",
  screenlocker    = "slock",

  -- brightness
  brightness_up        = "xbacklight -inc 1",
  brightness_up_more   = "xbacklight -inc 5",
  brightness_down      = "xbacklight -dec 1",
  brightness_down_more = "xbacklight -dec 5",
}

apps.editor_cmd   = apps.terminal .. " -e " .. apps.editor
menubar.utils.terminal = apps.terminal -- Set the terminal for applications that require it


return apps
