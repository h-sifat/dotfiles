local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-n>"] = nil,
				["<C-p>"] = nil,
			},
		},
	},

	extensions = {
		coc = {
			theme = "ivy",
			-- always use Telescope locations to preview definitions/declarations/implementations etc
			prefer_locations = true,
		},
	},
})

require("telescope").load_extension("coc")
