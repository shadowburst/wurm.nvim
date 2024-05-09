# wurm.nvim

`wurm.nvim` is a plugin that allows you to navigate your buffers logically.

## ⚡️ Requirements

- Neovim >= 0.5.0

## 📦 Installation

Install the plugin with your preferred package manager:

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "shadowburst/wurm.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<S-h>",
            "<cmd>WurmPrev<cr>",
            desc = "Navigate to previous buffer",
        },
        {
            "<S-l>",
            "<cmd>WurmNext<cr>",
            desc = "Navigate to next buffer",
        },
    },
}
```

## ⚙️ Configuration

There aren't any options for this plugin yet. I'm open to suggestions for new features.
