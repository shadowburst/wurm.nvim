# wurm.nvim

Worm your way through your **M**ost **R**ecent **U**sed files, going forwards and backwards through history.

## ⚡️ Requirements

- Neovim >= 0.5.0

## 📦 Installation

Install the plugin with your preferred package manager:

Using [lazy.nvim][lazy] :

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

<details>

<summary>Default Settings</summary>

<!-- config:start -->

```lua
{
    -- Number of files to remember
    max_history = 15
    -- Remove closed buffers from history
    forget_closed = true
}
```

<!-- config:end -->

</details>

## 📦 Similar Plugins / Inspiration

- [vim-buffer-history][vim-buffer-history]: design concepts
- [lazy.nvim][lazy]: pretty `README`s

[lazy]: https://github.com/folke/lazy.nvim
[vim-buffer-history]: https://github.com/dhruvasagar/vim-buffer-history
