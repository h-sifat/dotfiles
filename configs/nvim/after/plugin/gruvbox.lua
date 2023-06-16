vim.o.background = "dark"

require("gruvbox").setup({
  contrast = "hard",
  palette_overrides = {
    dark0_hard = "#1c2121"
  },
})

vim.cmd("colorscheme gruvbox")
