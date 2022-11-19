require("user.neovim").config()

require("user.alpha").config()

-- In order to disable lunarvim's default colorscheme
lvim.colorscheme = "default"

lvim.builtin.bufferline.options.always_show_bufferline = true

require("user.statusline").config()

lvim.builtin.terminal.shell = "/opt/homebrew/bin/fish"
lvim.builtin.terminal.active = true
-- lvim.builtin.terminal.open_mapping = "<M-Space>" -- ctrl+`
lvim.builtin.nvimtree.setup.view.mappings.list = {
  -- { key = { "<Tab>" }, action = nil },
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

require("user.treesitter").config()

require("user.lsp").config()

require("user.plugins").config()

require("user.keybindings").config()


-- set a formatter, this will override the language server formatting capabilities (if it exists)
lvim.format_on_save.enabled = true

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}
