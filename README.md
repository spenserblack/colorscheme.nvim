# colorschemecycle.nvim

## Usage

- `:ColorschemeCycle` / `:ColorschemeCycle select`: Open a menu to preview and select a colorscheme
- `:ColorschemeCycle next`: Use the next available colorscheme
- `:ColorschemeCycle prev`: use the previous available colorscheme

## Installation

With [lazy.nvim][lazy-nvim]:

```lua
-- plugins.lua
return {
  "spenserblack/colorschemecycle.nvim",
  -- ...
}
```

### Dependencies

If you install with [lazy.nvim][lazy-nvim] these should be handled automatically, but if you use
another package manager then you may need to manually install these dependencies.

- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)

[lazy-nvim]: https://github.com/folke/lazy.nvim
