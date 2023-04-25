local M = {}

M.config = function()
	require("neoai").setup({
		inject = {
			cutoff_width = nil,
		},
		shortcuts = {
			{
				name = "textify",
				key = "<leader>as",
				desc = "fix text with AI",
				use_context = true,
				prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
				modes = { "v" },
				strip_function = nil,
			},
			{
				name = "explain",
				desc = "explain selected text/code",
				use_context = true,
				prompt = [[
        解释这段代码
      ]],
				modes = { "v", "V" },
				strip_function = nil,
			},
			{
				name = "translate",
				desc = "translate selected text to english",
				use_context = true,
				prompt = [[
        请将这段文本翻译成英文, 不要输出与翻译内容无关的内容, 仅输出翻译结果, 不要输出引号
      ]],
				modes = { "v", "V" },
				strip_function = nil,
			},
		},
	})
end

return M
