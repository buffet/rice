local dpi = require("beautiful.xresources").apply_dpi
local menubar = require("menubar")

apps = {

  -- Your default terminal
  terminal        = "alacritty",

  -- Your default text editor
  editor          = os.getenv("EDITOR") or "vim",

  -- editor_cmd = terminal .. " -e " .. editor,

  -- Your default browser
  browser         = "firefox",

  -- Your default screenshot tool
  screenshot      = "flameshot gui",

  -- Screenlocker
  screenlocker    = "i3lock -ec '#fdf6e3'",

  -- brightness
  brightness_up   = "brightnessctl s 5%+",
  brightness_down = "brightnessctl s 5%-",
}

apps.editor_cmd   = apps.terminal .. " -e " .. apps.editor
menubar.utils.terminal = apps.terminal -- Set the terminal for applications that require it


return apps
