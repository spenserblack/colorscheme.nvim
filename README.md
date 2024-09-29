# colorschemecycle.nvim

## Usage

- `:ColorschemeCycle` / `:ColorschemeCycle select`: Open a menu to preview and select a colorscheme
- `:ColorschemeCycle next`: Use the next available colorscheme
- `:ColorschemeCycle prev`: use the previous available colorscheme

### Keymapping

If you're quickly previewing several colorschemes, using a keymap will likely be easier
than calling the `:ColorschemeCycle` command repeatedly. For example, the following
examples will allow you to cycle to the next and previous colorscheme with
`Ctrl` + `c` + `↓` and `Ctrl` + `c` + `↑`.

```lua
-- init.lua
vim.keymap.set('n', '<C-c><down>', '<cmd>ColorschemeCycle next<cr>')
vim.keymap.set('n', '<C-c><up>', '<cmd>ColorschemeCycle prev<cr>')
```

```vim
" init.vim
nnoremap <C-c><down> :ColorschemeCycle next<CR>
nnoremap <C-c><up> :ColorschemeCycle prev<CR>
```

## Installation

With [lazy.nvim][lazy-nvim]:

```lua
-- plugins.lua
return {
  "spenserblack/colorschemecycle.nvim",
  -- ...
}
```

[lazy-nvim]: https://github.com/folke/lazy.nvim
