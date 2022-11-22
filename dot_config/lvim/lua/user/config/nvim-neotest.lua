local M = {}

M.config = function()
	require("neotest").setup({
		adapters = {
			require("neotest-python")({
				-- Extra arguments for nvim-dap configuration
				-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
				dap = { justMyCode = false },
				-- Command line arguments for runner
				-- Can also be a function to return dynamic values
				args = { "--log-level", "DEBUG" },
				-- Runner to use. Will use pytest if available by default.
				-- Can be a function to return dynamic value.
				runner = "pytest",
				-- Custom python path for the runner.
				-- Can be a string or a list of strings.
				-- Can also be a function to return dynamic value.
				-- If not provided, the path will be inferred by checking for
				-- virtual envs in the local directory and for Pipenev/Poetry configs
				python = "python",
				-- Returns if a given file path is a test file.
				-- NB: This function is called a lot so don't perform any heavy tasks within it.
				-- is_test_file = function(file_path)
				--   ...
				-- end,
			}),
		},
	})

	-- lvim.builtin.which_key.mappings.s.n = {
	-- 	"<CMD>Telescope notify<CR>",
	-- 	"Notify History",
	-- }
	lvim.builtin.which_key.mappings.R = {
		name = "Run Tests",
		r = { "<CMD>lua require('neotest').run.run()<CR>", "运行附近的测试" },
		d = { "<CMD>lua require('neotest').run.run({strategy = 'dap'})<CR>", "运行附近的测试(DEBUG)" },
		s = { "<CMD>lua require('neotest').run.stop()<CR>", "停止" },
		c = { "<CMD>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "运行当前文件" },
		S = { "<CMD>lua require('neotest').summary.open()<CR>", "查看测试概要" },
	}
end

return M
