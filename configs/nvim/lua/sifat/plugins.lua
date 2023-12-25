require("lazy").setup({
	"mkitt/tabline.vim",
	"nvim-tree/nvim-web-devicons",
	"ryanoasis/vim-devicons",
	{ "neoclide/coc.nvim", branch = "release" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000 },
	{ "nvim-treesitter/nvim-treesitter", cmd = "TSUpdate" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim", "fannheyward/telescope-coc.nvim" },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { map_cr = false, check_ts = true }, -- this is equalent to setup({}) function
	},
	{
		"numToStr/Comment.nvim",
		keys = { "gcc", "gbc" },
		opts = { mappings = { basic = true, extra = true } },
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"NvChad/nvterm",
		config = function(_, opts)
			require("nvterm").setup(opts)
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		config = function()
			vim.fn["mkdp#util#install"]()
		end,

		ft = { "markdown" },
	},
})
