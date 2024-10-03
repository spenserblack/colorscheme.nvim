local function show_menu()
  local colorscheme = require("colorscheme")
  local Menu = require("nui.menu")
  local event = require("nui.utils.autocmd").event

  local previous_color = vim.g.colors_name
  local previous_bg = vim.o.background

  local function reset()
    vim.o.background = previous_bg
    vim.cmd.colorscheme(previous_color)
  end

  local popup_options = {
    position = {
      row = "90%",
      col = "50%",
    },
    size = {
      width = "80%",
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

  local dark_colorschemes = colorscheme.get_dark_colorschemes()
  local light_colorschemes = colorscheme.get_light_colorschemes()
  local neutral_colorschemes = colorscheme.get_neutral_colorschemes()

  local sections = {
    { label = "Dark", colorschemes = dark_colorschemes, background = "dark", duplicate_finders = {
      colorscheme.has_light_colorscheme,
      colorscheme.has_neutral_colorscheme,
    } },
    { label = "Light", colorschemes = light_colorschemes, background = "light", duplicate_finders = {
      colorscheme.has_dark_colorscheme,
      colorscheme.has_neutral_colorscheme,
    } },
    { label = "Neutral", colorschemes = neutral_colorschemes, duplicate_finders = {
      -- NOTE This should never actually happen, since a dark colorscheme should only have
      --      a light counterpart and never a neutral counterpart, and the same for
      --      light colorschemes, but just in case.
      colorscheme.has_dark_colorscheme,
      colorscheme.has_light_colorscheme,
    } },
  }

  local lines = {}
  for _, section in ipairs(sections) do
    table.insert(lines, Menu.separator(section.label .. " Colorschemes"))
    for _, colorscheme in ipairs(section.colorschemes) do
      local has_duplicate = false
      for _, duplicate_finder in ipairs(section.duplicate_finders) do
        if duplicate_finder(colorscheme) then has_duplicate = true end
      end

      local name = (has_duplicate and colorscheme .. " (" .. string.lower(section.label) .. ")") or colorscheme

      table.insert(lines, Menu.item(name, {
        colorscheme = colorscheme,
        background = section.background,
      }))
    end
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
      reset()
    end,
    on_change = function(item, menu)
      vim.o.background = item.background
      vim.cmd.colorscheme(item.colorscheme)
    end,
    on_submit = function(item)
      print(item.colorscheme)
    end
  })

  menu:mount()

  menu:on(event.BufLeave, function()
    menu:unmount()
  end)
end

vim.api.nvim_create_user_command('Colorscheme', show_menu, {
  nargs = 0,
})

local function toggle_theme()
  local next_theme = (vim.o.background == "dark" and "light") or "dark"
  local theme = require("colorscheme").resolve_theme(next_theme)
  vim.o.background = theme.background
  vim.cmd.colorscheme(theme.colorscheme)
end

vim.api.nvim_create_user_command("ColorschemeToggle", toggle_theme, {
  nargs = 0,
})
