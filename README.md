# colorscheme.nvim

## Usage

- `:Colorscheme`: Open a menu to preview and select a colorscheme
- `:ColorschemeToggle`: Switch between your preferred dark and light colorschemes

## Installation

With [lazy.nvim][lazy-nvim]:

```lua
-- plugins.lua
return {
  "spenserblack/colorscheme.nvim",
  -- ...
}
```

### Dependencies

If you install with [lazy.nvim][lazy-nvim] these should be handled automatically, but if you use
another package manager then you may need to manually install these dependencies.

- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)

[lazy-nvim]: https://github.com/folke/lazy.nvim

### Configuration

#### Choosing colorscheme preferences

Through the `setup` function, you can pass the settings `preferred_dark_colorscheme`,
`preferred_light_colorscheme`, and `theme_mode`. The preferred colorschemes should be
names of one of the available colorschemes. `theme_mode` can be one of the following:

- `dark`
- `light`
- `system`

When the `theme_mode` is `system`, this plugin will do its best to guess your system's
preferred colors. This will be determined when the plugin first starts up and needs to
query the preferred theme.

**NOTE:** If you want to dynamically change the colorscheme's background,
*you may not need this plugin.* Neovim should set your `background` option based on the
background of your terminal. This is different from querying the system theme, but this
might be good enough for you. Some colorschemes have both a dark and light mode.

**WARNING:** Detecting the system theme currently only works on Windows and Linux
*with a GNOME DE.* Any help to expand support is appreciated.

##### Example

```lua
require("colorscheme").setup({
  preferred_dark_colorscheme = "habamax",
  preferred_light_colorscheme = "default",
  theme_mode = "system",
})
```

#### Adding and removing colorschemes in the menu

This plugin comes with a default list of selectable colorschemes, based on the defaults that
come with Neovim 0.10.1. Unfortunately, if you add your own custom colorscheme, this
plugin will not be aware of it. This is because this plugin currently doesn't know if it
should put your colorscheme under the "dark", "light", or "neutral" colorscheme sections.

There are several helper functions to allow you to manage the known colorschemes.

```lua
-- For each of these, there is a dark/light/neutral counterpart
require("colorscheme").add_dark_colorscheme("black")
require("colorscheme").remove_light_colorscheme("default")
require("colorscheme").set_neutral_colorschemes({ "red", "green", "blue" })
```
