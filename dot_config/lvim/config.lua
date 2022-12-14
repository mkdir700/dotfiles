require("user.neovim").config()

require("user.alpha").config()

-- In order to disable lunarvim's default colorscheme
lvim.colorscheme = "default"
vim.opt.termguicolors = true
lvim.builtin.bufferline.options.always_show_bufferline = true
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

require("user.statusline").config()

-- lvim.builtin.terminal.shell = "/opt/homebrew/bin/fish"
-- lvim.builtin.terminal.active = true
-- lvim.builtin.terminal.open_mapping = "<M-Space>" -- ctrl+`
lvim.builtin.nvimtree.setup.view.mappings.list = {
	{ key = { "l", "<CR>" }, action = "edit", mode = "n" },
	{ key = "h", action = "close_node" },
	{ key = "v", action = "vsplit" },
}

----------------------------------------
-- Telescope
----------------------------------------
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<Esc>"] = actions.close,
	},
	-- for normal mode
	n = {},
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = true })

require("user.treesitter").config()

require("user.lsp").config()

require("user.plugins").config()

require("user.keybindings").config()

require("user.config.toggleterm").config()

require("user.telescope").config()
