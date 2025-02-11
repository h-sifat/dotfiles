vim.g.mapleader = " "

local function table_merge(base, new)
	for key, value in pairs(new) do
		base[key] = value
	end
end

local function toggle_jump_float()
	if vim.fn.win_gettype() == "popup" then
		vim.cmd("wincmd w")
	elseif vim.fn["coc#float#has_float"]() ~= 0 then
		vim.fn["coc#float#jump"]()
	end
end

local executor_commands_for_file_extensions = {
	mjs = "node",
	cjs = "node",
	js = "node",
	ts = "ts-node --swc ",
	lua = "lua",
	sh = "bash",
	py = "python3",
	go = "go run",
	rs = "cargo run",
}

local execute_current_file = function()
	local file_extension = vim.fn.expand("%:e")
	local executor_command = executor_commands_for_file_extensions[file_extension]

	if executor_command == nil then
		print("no command found to execute '" .. file_extension .. "' file.")
		return
	end

	local filepath = vim.fn.expand("%:p")
	local command

	if type(executor_command) == "function" then
		command = executor_command(filepath)
	else
		command = executor_command .. " " .. filepath
	end

	vim.fn.execute("vs | te " .. command)
end

local terminal_mappings = {
	["<leader>tj"] = {
		function()
			require("nvterm.terminal").new("horizontal")
		end,
		"New horizontal term",
	},

	["<leader>tt"] = {
		function()
			require("nvterm.terminal").new("vertical")
		end,
		"New vertical term",
	},
	["<leader>tk"] = {
		function()
			require("nvterm.terminal").toggle("float")
		end,
		"Toggle floating term",
	},
}

local keymaps = {
	i = {
		["<C-h>"] = { "<Left>", "Move left" },
		["<C-l>"] = { "<Right>", "Move right" },
	},
	n = {
		["<leader>e"] = { ":CocCommand explorer <cr>", "Toggle file explorer" },
		["<leader>w"] = { "<cmd> w <CR>", "Save file" },
		["<leader>q"] = { "<cmd> q <CR>", "Quit file" },
		["<leader>h"] = { "<C-w>h", "Window left" },
		["<leader>l"] = { "<C-w>l", "Window right" },
		["<leader>j"] = { "<C-w>j", "Window down" },
		["<leader>k"] = { "<C-w>k", "Window up" },
		["<F4>"] = { execute_current_file, "Execute the current file" },
		["<leader>1"] = { "<cmd> tabnew <CR>", "New tab" },
		["<leader>/"] = { "<cmd> tabp <CR>", "Prev tab" },
		["<leader>;"] = { "<cmd> tabn <CR>", "Next tab" },
		["<leader>2"] = { "<cmd> tabc <CR>", "Close tab" },
		["<leader>p"] = { '"+p', "Paste from system clipboard" },
		["<C-Right>"] = { "<cmd> vertical resize +2 <CR>", "Horizontal resize +" },
		["<C-Left>"] = { "<cmd> vertical resize -2 <CR>", "Horizontal resize -" },
		["<C-Up>"] = { "<cmd> resize +2 <CR>", "vertical resize +" },
		["<C-Down>"] = { "<cmd> resize -2 <CR>", "vertical resize -" },
		["<Esc>"] = { ":noh <CR>", "Clear highlights" },
		["<leader>r"] = { "<Plug>(coc-rename)", "Rename symbols" },
		["<leader>d"] = { ":<C-u>CocList diagnostics<cr>", "Show all diagnostics" },
		["<leader>x"] = { ":<C-u>CocList extensions<cr>", "Show all extensions" },
		["<leader>m"] = { ":<C-u>CocList marketplace<cr>", "Open marketplace" },
		["<leader>i"] = { "<Plug>(coc-fix-current)", "Apply Quickfix" },
		["<leader>z"] = { ":<C-u>CocList commands<cr>", "List all commands" },
		["<leader>o"] = { ":<C-u>CocList outline<cr>", "Find symbol of current document" },
		["<leader>s"] = { ":<C-u>CocList -I symbols<cr>", "Search workspace symbols" },
		["<leader>u"] = { ":<C-u>CocCommand snippets.editSnippets<cr>", "Search workspace symbols" },
		["<leader>a"] = { "<Plug>(coc-codeaction-cursor)", "Code action" },
		["<leader>f"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Telescope find files" },
		["<leader>g"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Telescope live grep" },
		["<leader>y"] = { ":CocCommand snippets.editSnippets<cr>", "Edit curernt file's language's snippets" },
		["<leader>c"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"Toggle comment",
		},
		["<C-P>"] = { "<cmd> MarkdownPreviewToggle<CR>", "Toggle markdown preview" },
		["U"] = { toggle_jump_float, "toggle jump float window" },
	},
	v = {
		["<leader>y"] = { '"+y', "Copy to system clipboard" },
		J = { ":m '>+1<CR>gv=gv", "Move selection down" },
		K = { ":m '<-2<CR>gv=gv", "Move selection up" },

		["<leader>c"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"Toggle comment",
		},
	},
	t = {
		["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
	},
}

table_merge(keymaps.n, terminal_mappings)
table_merge(keymaps.t, terminal_mappings)

for mode, list in pairs(keymaps) do
	for key, cmd_and_description in pairs(list) do
		-- print(mode .. " - " .. key .. " > " .. cmd_and_description[1])
		vim.keymap.set(mode, key, cmd_and_description[1])
	end
end
