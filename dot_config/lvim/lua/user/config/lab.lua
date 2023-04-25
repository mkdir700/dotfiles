local M = {}

M.config = function()
	require("lab").setup({
    code_runner = {
      enabled = true,
    },
		quick_data = {
			enabled = true,
		},
	})
end

return M
