local create_autocmd = vim.api.nvim_create_autocmd

local options = {
	syntax = "ON",
	nu = true,
	rnu = true,
	spell = false,
	splitright = true,
	splitbelow = true,
	relativenumber = true,
	showmode = false,
	encoding = "UTF-8",
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	smartindent = true,
	wrap = false,
	swapfile = false,
	backup = false,
	undodir = os.getenv("HOME") .. "/.nvim/undodir",
	undofile = true,
	termguicolors = true,
	scrolloff = 3,
	signcolumn = "yes",
	clipboard = "",
	colorcolumn = "80",
}

vim.cmd([[
  autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']
]])

for option, value in pairs(options) do
	vim.opt[option] = value
end

create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.md", "*.MD", "*.txt" },
	command = "set textwidth=80",
})

create_autocmd({ "BufLeave" }, {
	pattern = { "*.md", "*.MD", "*.txt" },
	command = "set textwidth=0",
})

vim.g.mkdp_refresh_slow = 1
vim.g.mkdp_port = "4321"
vim.g.mkdp_theme = "light"
