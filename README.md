# colorscheme.nvim

## Usage

- `:Colorscheme`: Open a menu to preview and select a colorscheme

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

This plugin comes with a default list of selectable plugins, based on the defaults that
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
