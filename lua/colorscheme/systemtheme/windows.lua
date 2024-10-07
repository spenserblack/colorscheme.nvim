local function get_system_theme()
  local system_root = os.getenv("SystemRoot") or ""
  -- NOTE If %SystemRoot% isn't set for whatever reason, escape
  if system_root == "" then
    return "light"
  end
  local reg_path = table.concat(
    {
      system_root,
      "System32",
      "reg.exe",
    },
    "\\"
  )
  local registry_property_path = table.concat(
    {
      "HKCU",
      "SOFTWARE",
      "Microsoft",
      "Windows",
      "CurrentVersion",
      "Themes",
      "Personalize",
    },
    "\\"
  )
  local command = string.format(
    "%s QUERY %s /v AppsUseLightTheme",
    reg_path,
    registry_property_path
  )
  local handle = io.popen(command)
  local apps_use_light_theme = handle:read("*a"):match("0x(%x+)")
  handle:close()
  if not apps_use_light_theme then
    return "light"
  end
  if tonumber(apps_use_light_theme, 16) == 0 then
    return "dark"
  end
  return "light"
end

return get_system_theme()
