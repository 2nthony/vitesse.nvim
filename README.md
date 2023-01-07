# vitesse.nvim

**This colorscheme may not perfect because I do not know Vim configurations, I only forked [srvana/neosolarized.nvim](https://github.com/svrana/neosolarized.nvim) and change the colors.**

## Limitations

- Vitesse dark only
- Not 100% same as [vscode-theme-vitesse](https://github.com/antfu/vscode-theme-vitesse)
- Tested on neovim v0.8
- Change your terminal background to `#121212` (vitesse dark background).

## Usage

Packer:

```lua
use {
  "2nthony/vitesse.nvim",
  requires = {
    "tjdevries/colorbuddy.nvim"
  }
}
```

Setup:

```lua
require("vitesse").setup {
  comment_italics = true,
}
```

## Plugins supported

> Copy from origin repo

- nvim-cmp
- lsp-saga
- telescope
- vim-gitgutter
- neomake
- seblj/nvim-tabline
- kevinwhang91/nvim-bqf
- Primeagen/harpoon
- lewis6991/gitsigns.nvim
- phaazon/hop.nvim
- j-hui/fidget

## Thanks

This colorscheme is forked from [srvana/neosolarized.nvim](https://github.com/svrana/neosolarized.nvim), for more details you may need to check.
