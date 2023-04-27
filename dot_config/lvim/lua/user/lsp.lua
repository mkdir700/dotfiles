local M = {}

M.config = function()
	-- ---WARN: configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
	-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
	require("lvim.lsp.null-ls.linters").setup({
		{ filetypes = { "sh" }, command = "shellcheck" },
		{ filetypes = { "go" }, command = "golangci_lint" },
		-- { filetypes = { "python" }, command = "mypy", args = { "--ignore-missing-imports" } },
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
		{ filetype = { "cpp", "c", "objc", "objcpp" }, command = "clang-format" },
		{ filetypes = { "go" }, command = "gofmt" },
		{ filetypes = { "python" }, command = "isort" },
		{ filetypes = { "python" }, command = "black" },
		{ filetypes = { "lua" }, command = "stylua" },
		{ filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, command = "prettier" },
		{ filetypes = { "html", "css", "markdown" }, command = "prettier" },
	})

	-- 重新定义 lsp 的默认配置
	local common_on_attach = require("lvim.lsp").common_on_attach
	require("lvim.lsp").common_on_attach = function(client, bufnr)
		require("lsp_signature").on_attach({
			doc_lines = 10,
			floating_window = false,
			floating_window_above_cur_line = false,
			hint_enable = true,
			hint_prefix = "🦉: ",
			extra_trigger_chars = { "(", ",", "=" }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
			zindex = 1002, -- by default it will be on top of all floating windows, set to 50 send it to bottom
			toggle_key = "<C-k>",
			"/home/",
		})
		common_on_attach(client, bufnr)
	end
	local common_on_attach = require("lvim.lsp").common_on_attach

	local lspconfig = require("lspconfig")

	-- Configure `pyright` for python
	local python_root_files = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
		".mypy_cache",
		".venv",
		"venv",
	}

	lspconfig["pyright"].setup({
		on_attach = function(client, bufnr)
			common_on_attach(client, bufnr)
			-- 禁用 pyright 的 document_formatting，使用 null-ls 的 document_formatting
			client.server_capabilities.document_formatting = false
			-- 禁用 pyright 的 hoverProvider，使用 ruff-lsp 的 hoverProvider
			-- client.server_capabilities.hoverProvider = false
		end,
		root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
		filetypes = { "python", "py" },
	})

	-- 使用 pip 判断当前环境是否安装了 ruff-lsp

	lspconfig["ruff_lsp"].setup({
		on_attach = common_on_attach,
		root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
		filetypes = { "python", "py" },
	})

	-- 重写 lvim.lsp 的默认配置
	lvim.lsp.diagnostics.float.focusable = true
	-- 解决 cpp offsetEncoding 编码警告问题
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997226723
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.offsetEncoding = { "utf-16" }
	lspconfig["clangd"].setup({
		on_attach = common_on_attach,
		capabilities = capabilities,
		filetypes = { "c", "cpp", "objc", "objcpp", "cc", "h" },
	})
end

return M
