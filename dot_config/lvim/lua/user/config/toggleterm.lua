local M = {}

M.config = function()
	lvim.builtin.terminal.hide_numbers = false
	lvim.builtin.terminal.auto_scroll = false
	-- lvim.builtin.terminal.winbar = {
	-- 	enabled = true,
	-- 	name_formatter = function(term)
	-- 		return term.name
	-- 	end,
	-- }
	-- local opts = { buffer = 0 }
	-- lvim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	-- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	-- vim.keymap.set("t", "<A-h>", [[<Cmd>wincmd h<CR>]], opts)
	-- vim.keymap.set("t", "<A-j>", [[<Cmd>wincmd j<CR>]], opts)
	-- vim.keymap.set("t", "<A-k>", [[<Cmd>wincmd k<CR>]], opts)
	-- vim.keymap.set("t", "<A-l>", [[<Cmd>wincmd l<CR>]], opts)
end

return M
