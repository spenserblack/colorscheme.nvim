local M = {}

local Set = {}

Set.mt = {
  __index = function() return false end,
}

function Set.new(items)
  local set = {}
  for _, item in ipairs(items) do
    set[item] = true
  end
  setmetatable(set, Set.mt)
  return set
end

local preferred_dark_colorscheme = "default"
local preferred_light_colorscheme = "default"
local theme_mode = nil

local function set_as_sorted_list(set)
  sorted = {}
  for k in pairs(set) do
    table.insert(sorted, k)
  end
  table.sort(sorted)
  return sorted
end

local dark_colorschemes = Set.new{
  "darkblue",
  "default",
  "desert",
  "elflord",
  "evening",
  "habamax",
  "industry",
  "koehler",
  "lunaperche",
  "murphy",
  "pablo",
  "quiet",
  "retrobox",
  "ron",
  "slate",
  "sorbet",
  "torte",
  "vim",
  "wildcharm",
  "zaibatsu",
}
local light_colorschemes = Set.new{
  "default",
  "delek",
  "lunaperche",
  "morning",
  "peachpuff",
  "quiet",
  "retrobox",
  "shine",
  "wildcharm",
  "zellner",
}
local neutral_colorschemes = Set.new{"blue"}

local function add_colorscheme_factory(colorschemes)
  local function add_colorscheme(colorscheme)
    colorschemes[colorscheme] = true
  end
  return add_colorscheme
end

local function remove_colorscheme_factory(colorschemes)
  local function remove_colorscheme(colorscheme)
    colorschemes[colorscheme] = nil
  end
  return remove_colorscheme
end

local function has_colorscheme_factory(colorschemes)
  local function has_colorscheme(colorscheme)
    return colorschemes[colorscheme]
  end
  return has_colorscheme
end

M.add_dark_colorscheme = add_colorscheme_factory(dark_colorschemes)
M.add_light_colorscheme = add_colorscheme_factory(light_colorschemes)
M.add_neutral_colorscheme = add_colorscheme_factory(neutral_colorschemes)

M.remove_dark_colorscheme = remove_colorscheme_factory(dark_colorschemes)
M.remove_light_colorscheme = remove_colorscheme_factory(light_colorschemes)
M.remove_neutral_colorscheme = remove_colorscheme_factory(neutral_colorschemes)

function M.get_dark_colorschemes()
  return set_as_sorted_list(dark_colorschemes)
end
function M.get_light_colorschemes()
  return set_as_sorted_list(light_colorschemes)
end
function M.get_neutral_colorschemes()
  return set_as_sorted_list(neutral_colorschemes)
end

function M.set_dark_colorschemes(colorschemes)
  dark_colorschemes = Set.new(colorschemes)
end
function M.set_light_colorschemes(colorschemes)
  light_colorschemes = Set.new(colorschemes)
end
function M.set_neutral_colorschemes(colorschemes)
  neutral_colorschemes = Set.new(colorschemes)
end

M.has_dark_colorscheme = has_colorscheme_factory(dark_colorschemes)
M.has_light_colorscheme = has_colorscheme_factory(light_colorschemes)
M.has_neutral_colorscheme = has_colorscheme_factory(neutral_colorschemes)

local function get_system_theme()
  return require("colorscheme.systemtheme")
end

local function resolve_theme(theme_mode)
  if theme_mode == "dark" then
    return { background = "dark", colorscheme = preferred_dark_colorscheme }
  elseif theme_mode == "light" then
    return { background = "light", colorscheme = preferred_light_colorscheme }
  elseif theme_mode == "system" then
    return resolve_theme(get_system_theme())
  end
  return nil
end

function M.resolve_theme(mode)
  local theme_mode = mode or theme_mode
  return resolve_theme(theme_mode)
end

function M.setup(opts)
  if not opts then
    return
  end
  if opts.preferred_dark_colorscheme then
    preferred_dark_colorscheme = opts.preferred_dark_colorscheme
  end
  if opts.preferred_light_colorscheme then
    preferred_light_colorscheme = opts.preferred_light_colorscheme
  end
  if opts.theme_mode then
    theme_mode = opts.theme_mode
    local theme = resolve_theme(theme_mode)
    vim.o.background = theme.background
    vim.cmd.colorscheme(theme.colorscheme)
  end
end

return M
