local M = {}

M.config = function()
	-- ---WARN: configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
	-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`

	require("lvim.lsp.null-ls.linters").setup({
		{ filetypes = { "sh" }, command = "shellcheck" },
		{ filetypes = { "go" }, command = "golangci_lint" },
		{ filetypes = { "python" }, command = "mypy", args = { "--ignore-missing-imports" } },
		{ filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, command = "eslint" },
		{ filetypes = { "html" }, command = "tidy" },
		{ filetypes = { "css" }, command = "stylelint" },
		{ filetypes = { "markdown" }, command = "markdownlint", args = { "--disable", "MD013" } },
		-- { filetype = { "rust" }, command = "cargo", args = { "clippy", "--message-format=json" } },
	})

	lvim.format_on_save = { pattern = "*", timeout = 2000 }
	require("lvim.lsp.null-ls.formatters").setup({
		{ filetypes = { "sh" }, command = "shfmt", extra_args = { "-i", "2" } },
		{ filetypes = { "cmake" }, command = "cmake_format" },
		{ filetypes = { "go" }, command = "gofmt" },
		{ filetypes = { "python" }, command = "isort" },
		{
			filetypes = { "python" },
			command = "black",
			-- args = { "--style={based_on_style: google, column_limit: 120, indent_width: 4}" },
		},
		{ filetypes = { "lua" }, command = "stylua" },
		{ filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, command = "prettier" },
		{ filetypes = { "html", "css", "markdown" }, command = "prettier" },
	})

	-- 重新定义 lsp 的默认配置
	local attach = require("lvim.lsp").common_on_attach
	require("lvim.lsp").common_on_attach = function(client, bufnr)
		require("lsp_signature").on_attach({
			doc_lines = 10,
			floating_window = false,
			floating_window_above_cur_line = false,
			hint_enable = true,
			hint_prefix = " ",
			extra_trigger_chars = { "(", ",", "=" }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
			zindex = 1002, -- by default it will be on top of all floating windows, set to 50 send it to bottom
			toggle_key = "<C-k>",
			"/home/",
		})

		attach(client, bufnr)
	end

	local lspconfig = require("lspconfig")
	local python_root_files = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		"Makefile",
		".git",
		".mypy_cache",
	}
	lspconfig["pyright"].setup({
		on_attach = attach,
		root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
	})

	-- 重写 lvim.lsp 的默认配置
	lvim.lsp.diagnostics.float.focusable = true
end

return M
