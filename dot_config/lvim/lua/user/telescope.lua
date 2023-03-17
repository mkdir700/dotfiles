local M = {}

M.config = function()
	--  require("telescope.builtin").buffers({
	-- 	initial_mode = "insert",
	-- 	attach_mappings = function(prompt_bufnr, map)
	-- 		local actions = require("telescope.actions")
	-- 		map("i", "<C-d>", actions.delete_buffer)
	-- 		map("n", "<C-d>", actions.delete_buffer)
	-- 		return true
	-- 	end,
	-- })
	lvim.builtin.telescope.defaults.file_ignore_patterns = {
		"vendor/*",
		"%.lock",
		"__pycache__/*",
		"%.sqlite3",
		"%.ipynb",
		"node_modules/*",
		"%.jpg",
		"%.jpeg",
		"%.png",
		"%.svg",
		"%.otf",
		"%.ttf",
		".git/",
		"%.webp",
		".dart_tool/",
		".github/",
		".gradle/",
		".idea/",
		".settings/",
		".vscode/",
		"__pycache__/",
		"build/",
		"env/",
		"gradle/",
		"node_modules/",
		"target/",
		"%.pdb",
		"%.dll",
		"%.class",
		"%.exe",
		"%.cache",
		"%.ico",
		"%.pdf",
		"%.dylib",
		"%.jar",
		"%.docx",
		"%.met",
		"smalljre_*/*",
		".vale/",
	}
end

return M
