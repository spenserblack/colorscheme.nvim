local function get_os()
  local os_name = (vim.uv.os_uname().sysname or ""):lower()
  if os_name:find("linux") then
    return "linux"
  end
  return "unknown"
end

local os = get_os()
if os == "linux" then
  return require("colorscheme.systemtheme.linux")
end
return "light"
