local Module = {}

local default_dark_colorschemes = {
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

local default_light_colorschemes = {
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

local default_neutral_colorschemes = {
  "blue",
}

local function set_as_sorted_list(set)
  sorted = {}
  for k in pairs(set) do
    table.insert(sorted, k)
  end
  table.sort(sorted)
  return sorted
end

local function list_as_set(list)
  set = {}
  for _, v in ipairs(list) do
    set[v] = true
  end
  return set
end

local dark_colorschemes = list_as_set(default_dark_colorschemes)
local light_colorschemes = list_as_set(default_light_colorschemes)
local neutral_colorschemes = list_as_set(default_neutral_colorschemes)

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
    -- NOTE I don't like `== true`, but this casts `nil` to `false`, just in case
    --      someone expects a boolean.
    return colorschemes[colorscheme] == true
  end
  return has_colorscheme
end

Module.add_dark_colorscheme = add_colorscheme_factory(dark_colorschemes)
Module.add_light_colorscheme = add_colorscheme_factory(light_colorschemes)
Module.add_neutral_colorscheme = add_colorscheme_factory(neutral_colorschemes)

Module.remove_dark_colorscheme = remove_colorscheme_factory(dark_colorschemes)
Module.remove_light_colorscheme = remove_colorscheme_factory(light_colorschemes)
Module.remove_neutral_colorscheme = remove_colorscheme_factory(neutral_colorschemes)

function Module.get_dark_colorschemes()
  return set_as_sorted_list(dark_colorschemes)
end
function Module.get_light_colorschemes()
  return set_as_sorted_list(light_colorschemes)
end
function Module.get_neutral_colorschemes()
  return set_as_sorted_list(neutral_colorschemes)
end

function Module.set_dark_colorschemes(colorschemes)
  dark_colorschemes = list_as_set(colorschemes)
end
function Module.set_light_colorschemes(colorschemes)
  light_colorschemes = list_as_set(colorschemes)
end
function Module.set_neutral_colorschemes(colorschemes)
  neutral_colorschemes = list_as_set(colorschemes)
end

Module.has_dark_colorscheme = has_colorscheme_factory(dark_colorschemes)
Module.has_light_colorscheme = has_colorscheme_factory(light_colorschemes)
Module.has_neutral_colorscheme = has_colorscheme_factory(neutral_colorschemes)

return Module
