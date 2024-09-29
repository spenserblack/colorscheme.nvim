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

local function show_menu()
  local previous_color = vim.g.colors_name
  local Menu = require("nui.menu")
  local event = require("nui.utils.autocmd").event

  local popup_options = {
    position = "90%",
    size = {
      width = 25,
      height = 10,
    },
    border = {
      style = "single",
      text = {
        top = "Choose a colorscheme",
        top_align = "center",
      },
    },
    win_options = {
      winblend = 10,
      winhighlight = "Normal:Normal",
    }
  }
  local lines = {}
  for i, color in ipairs(colors) do
    lines[i] = Menu.item(color)
  end
  local menu = Menu(popup_options, {
    lines = lines,
    max_width = 20,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>" },
      submit = { "<CR>", "<Space>" },
    },
    on_close = function()
      vim.cmd.colorscheme(previous_color)
    end,
    on_change = function(item, menu)
      vim.cmd.colorscheme(item.text)
    end,
    on_submit = function(item)
      local selected = nil
      index, selected = selected_color()
      print(selected)
    end
  })

  menu:mount()

  menu:on(event.BufLeave, function()
    menu:unmount()
  end)
end

local function cycle_colorscheme(opts)
  index, _ = selected_color()
  local direction = opts.fargs[1] or 'select'
  if direction == 'next' then
    increment_index()
  elseif direction == 'prev' then
    decrement_index()
  elseif direction == 'select' then
    show_menu()
    return
  end
  local selected = colors[index]
  vim.cmd.colorscheme(selected)
  print(selected)
end

local function completions(ArgLead, CmdLine, CursorPos)
  return { "next", "prev", "select" }
end

vim.api.nvim_create_user_command('ColorschemeCycle', cycle_colorscheme, {
  nargs = "?",
  complete = completions,
})

