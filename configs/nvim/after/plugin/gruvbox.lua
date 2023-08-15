vim.o.background = "dark"

require("gruvbox").setup({
	contrast = "hard",
	palette_overrides = {
		dark0_hard = "#1c2121",
	},
	italic = {
		strings = false,
		comments = false,
		operators = false,
		folds = false,
	},
})

vim.cmd("colorscheme gruvbox")
