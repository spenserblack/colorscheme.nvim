local function get_os()
  local sysname = (vim.uv.os_uname().sysname or ""):lower()

  local finders = {
    linux = "linux",
    windows = "windows",
  }
  for hint, os_name in pairs(finders) do
    if sysname:find(hint) then
      return os_name
    end
  end

  return "unknown"
end

return require(string.format("colorscheme.systemtheme.%s", get_os()))
