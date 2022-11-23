local M = {}

M.config = function()
	-- ---WARN: configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
	-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
	vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

	local on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		local bufopts = { silent = true, noremap = true, buffer = bufnr }
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)
		-- vim.keymap.set("n", "gl", function()
		-- 	local config = lvim.lsp.diagnostics.float
		-- 	config.scope = "line"
		-- 	vim.diagnostic.open_float(0, config)
		-- end, bufopts)
	end
	local lsp_flags = {
		-- This is the default in Nvim 0.7+
		debounce_text_changes = 150,
	}
	require("lspconfig")["rust_analyzer"].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		-- Server-specific settings...
		settings = {
			["rust-analyzer"] = {},
		},
	})
	require("lvim.lsp.null-ls.linters").setup({
		{ filetypes = { "sh" }, command = "shellcheck" },
		{ filetypes = { "go" }, command = "golangci_lint" },
		{ filetypes = { "python" }, command = "mypy" },
		{ filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, command = "eslint" },
		{ filetypes = { "html" }, command = "tidy" },
		{ filetypes = { "css" }, command = "stylelint" },
		{ filetypes = { "markdown" }, command = "markdownlint", args = { "--disable", "MD013" } },
	})

	lvim.format_on_save = { pattern = "*", timeout = 2000 }
	require("lvim.lsp.null-ls.formatters").setup({
		{ filetypes = { "sh" }, command = "shfmt", extra_args = { "-i", "2" } },
		{ filetypes = { "cmake" }, command = "cmake_format" },
		{ filetypes = { "go" }, command = "gofmt" },
		{
			filetypes = { "python" },
			command = "black",
			-- args = { "--style={based_on_style: google, column_limit: 120, indent_width: 4}" },
		},
		{ filetypes = { "lua" }, command = "stylua" },
		{ filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, command = "prettier" },
		{ filetypes = { "html", "css", "markdown" }, command = "prettier" },
	})
end

return M
