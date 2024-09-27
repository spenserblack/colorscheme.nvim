local colors = vim.fn.getcompletion("", "color")

-- Gets the index and name of the current color
local function selected_color()
  local selected = vim.g.colors_name
  for index, color in ipairs(colors) do
    if color == selected then
      return index, color
    end
  end
end

local index, _ = selected_color()

local function increment_index()
  index = (index % #colors) + 1
end

local function decrement_index()
  index = ((index - 2) % #colors) + 1
end

local function cycle_colorscheme(opts)
  local direction = opts.fargs[1] or 'next'
  if direction == 'next' then
    increment_index()
  elseif direction == 'prev' then
    decrement_index()
  end
  local selected = nil
  index, selected = selected_color()
  vim.cmd.colorscheme(selected)
  print(selected)
end

local function completions(ArgLead, CmdLine, CursorPos)
  return { "next", "prev" }
end

vim.api.nvim_create_user_command('CycleColorscheme', cycle_colorscheme, {
  nargs = "?",
  complete = completions,
})

