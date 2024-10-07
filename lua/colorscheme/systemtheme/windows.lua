-- TODO Spawning a PowerShell process seems to be really slow. Find a better way to read
--      the registry?
local function get_system_theme()
  local system_root = os.getenv("SystemRoot") or ""
  -- NOTE If %SystemRoot% isn't set for whatever reason, escape
  if system_root == "" then
    return "light"
  end
  local powershell_path = table.concat(
    {
      system_root,
      "System32",
      "WindowsPowerShell",
      "v1.0",
      "powershell.exe",
    },
    "\\"
  )
  local registry_property_path = table.concat(
    {
      "HKCU:",
      "SOFTWARE",
      "Microsoft",
      "Windows",
      "CurrentVersion",
      "Themes",
      "Personalize",
    },
    "\\"
  )
  local ps_command = string.format(
    "Get-ItemPropertyValue -Path %s  -Name AppsUseLightTheme",
    registry_property_path
  )
  local command = string.format(
    "%s -NonInteractive -Command %q",
    powershell_path,
    ps_command
  )
  local handle = io.popen(command)
  local apps_use_light_theme = handle:read("*a"):match("^%s*(%d+)%s*$")
  handle:close()
  if apps_use_light_theme == "0" then
    return "dark"
  end
  return "light"
end

return get_system_theme()
