local M = {}

M.config = function()
	-- 禁用默认的terminal
  lvim.builtin.terminal.direction = "horizontal"
	lvim.builtin.terminal.execs = {}
	lvim.builtin.terminal.hide_numbers = false
	lvim.builtin.terminal.auto_scroll = false
	lvim.builtin.terminal.shade_terminals = false
	vim.keymap.set({ "n", "t", "i" }, "<M-1>", "<CMD>ToggleTerm direction=horizontal<CR>")
	vim.keymap.set({ "n", "t", "i" }, "<M-2>", "<CMD>ToggleTerm direction=vertical<CR>")
	vim.keymap.set({ "n", "t", "i" }, "<M-3>", "<CMD>ToggleTerm direction=float<CR>")

	-- TODO: 临时方案，用于快速加载当前项目的虚拟环境（仅支持poetry）
	vim.keymap.set(
		{ "n", "t", "i" },
		"<M-4>",
		"<CMD>TermExec cmd='source $(poetry env info -p)/bin/activate' direction=horizontal<CR>"
	)
	-- ipython
	-- vim.keymap.set(
	-- 	{ "n", "t", "i" },
	-- 	"<M-4>",
	-- 	"<CMD>TermExec cmd='source $(poetry env info -p)/bin/activate && ipython' direction=horizontal<CR>"
	-- )
	lvim.builtin.which_key.mappings.a.e = {
		"<CMD>ToggleTermSendCurrentLine<CR>",
		"Send current line to terminal",
	}
	-- FIXME
	lvim.builtin.which_key.vmappings.a.e = {
		"<CMD>'<,'>ToggleTermSendVisualLines<CR>",
		"Send visual lines to terminal",
	}
	lvim.builtin.which_key.vmappings.a.E = {
		"<CMD>'<,'>ToggleTermSendVisualSelection<CR>",
		"Send visual selection to terminal",
	}

	function _G.set_terminal_keymaps()
		local opts = { buffer = 0, noremap = true }
		local bufname = vim.fn.bufname("%")
		if not string.find(bufname, "lazygit") then
			-- 只在打开非 lazygit 终端时设置映射
			vim.keymap.set("t", "<esc>", "<C-\\><C-n>", opts)
			vim.keymap.set("t", "jk", "<C-\\><C-n>", opts)
			vim.keymap.set("t", "<C-k>", "<Cmd>wincmd p<CR>", opts)
			-- <C-l> 清空终端
			vim.api.nvim_set_keymap(
				"t",
				"<C-l>",
				'<Cmd>lua vim.api.nvim_buf_call(0, function() vim.cmd(\'TermExec cmd="clear"\') vim.fn.feedkeys("a") end)<CR>',
				{ noremap = true, silent = true }
			)
		end
	end

	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", count = 5 })
	-- vim.api.nvim_create_user_command("ToggleTermSendCurrentLine", function(opts)
	-- 	send_term("single_line", false, opts.args)
	-- end, { nargs = "?", force = true })
	-- vim.api.nvim_create_user_command("ToggleTermSendVisualSelection", function(opts)
	-- 	send_term("visual_selection", false, opts.args)
	-- end, { range = true, nargs = "?", force = true })
	-- vim.api.nvim_create_user_command("ToggleTermSendVisualLines", function(opts)
	-- 	send_term("visual_lines", false, opts.args)
	-- end, { range = true, nargs = "?", force = true })
	-- vim.api.nvim_create_user_command("ToggleTermSendCurrentLineNoTrimWs", function(opts)
	-- 	send_term("single_line", false, opts.args)
	-- end, { nargs = "?", force = false })
end

return M
