local function get_desktop_environment()
  local desktop = (os.getenv("XDG_CURRENT_DESKTOP") or ""):lower()
  if not desktop then
    return "unknown"
  end
  if desktop:find("gnome") then
    return "gnome"
  end
  return "unknown"
end

local function get_gnome_system_theme()
  -- NOTE "default" or "prefer-dark"
  local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme")
  local theme = handle:read("*a")
  handle:close()
  if theme:match("dark") then
    return "dark"
  end
  return "light"
end

local function get_system_theme()
  local desktop_environment = get_desktop_environment()
  if desktop_environment == "gnome" then
    return get_gnome_system_theme()
  end
  return nil
end

return get_system_theme()
