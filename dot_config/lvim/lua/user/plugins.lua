local M = {}

M.config = function()
	lvim.plugins = {
		--------------
		-- 屏幕滚动 --
		--------------
		{
			"karb94/neoscroll.nvim",
			event = "WinScrolled",
			config = function()
				require("user.config.neoscroll").config()
			end,
		},
		--------------
		-- 光标移动 --
		--------------
		{
			"rhysd/clever-f.vim",
			keys = { "f", "F", "t", "T" },
			setup = function()
				require("user.setup.clever-f").setup()
			end,
		},
		{
			"phaazon/hop.nvim",
			cmd = "Hop*",
			config = function()
				require("user.config.hop").config()
			end,
		},
		{
			"ggandor/leap.nvim",
			event = "BufRead",
			keys = { "s", "S" },
			config = function()
				require("user.config.leap-nvim").config()
			end,
		},
		{
			"andymass/vim-matchup",
			event = "CursorMoved",
			setup = function()
				require("user.setup.matchup").setup()
			end,
		},
		{
			"nacro90/numb.nvim",
			config = function()
				require("numb").setup()
			end,
		},
		--------------
		-- 标签跳转 --
		--------------
		{
			"ethanholz/nvim-lastplace",
			event = "BufRead",
			config = function()
				require("user.config.lastplace").config()
			end,
		},
		{
			"MattesGroeger/vim-bookmarks",
			event = "BufRead",
			setup = function()
				require("user.setup.bookmarks").setup()
			end,
			config = function()
				require("user.config.bookmarks").config()
			end,
		},
		{
			"tom-anders/telescope-vim-bookmarks.nvim",
			keys = { "ml", "mL" },
			config = function()
				require("user.config.telescope-vim-bookmarks").config()
			end,
		},
		-- 预览
		{
			"rmagatti/goto-preview",
			config = function()
				require("goto-preview").setup({})
				vim.api.nvim_set_keymap(
					"n",
					"gp",
					"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
					{ noremap = true }
				)
				-- vim.keymap.set(
				-- 	"n",
				-- 	"gpd",
				-- 	"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
				-- 	{ silent = true }
				-- )
				-- vim.keymap.set(
				-- 	"n",
				-- 	"gpt",
				-- 	"<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
				-- 	{ silent = true }
				-- )
				-- vim.keymap.set(
				-- 	"n",
				-- 	"gpi",
				-- 	'<cmd>lua require("goto-preview").goto_preview_implementation()<CR>',
				-- 	{ silent = true }
				-- )
				-- vim.keymap.set("n", "gpp", "<cmd>lua require('goto-preview').close_all_win()<CR>", { silent = true })
				-- vim.keymap.set(
				-- 	"n",
				-- 	"gpr",
				-- 	"<cmd> lua require('goto-preview').goto_preview_references()<CR>",
				-- 	{ silent = true }
				-- )
			end,
		},
		--------------
		-- 全文搜索 --
		--------------
		{
			"bronson/vim-visual-star-search",
			keys = { { "v", "*" }, { "v", "#" }, { "v", "g*" }, { "v", "g#" } },
		},
		{
			"romainl/vim-cool",
			event = "CursorMoved",
		},
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			keys = { "<C-S-F>" },
			config = function()
				require("user.config.telescope-live-grep-args").config()
			end,
		},
		{
			"windwp/nvim-spectre",
			keys = { "<C-h>", { "v", "C-h>" }, "<C-S-H>", { "v", "<C-S-H>" } },
			config = function()
				require("user.config.spectre").config()
			end,
		},
		{ "ggandor/flit.nvim" },
		--------------
		-- 快速编辑 --
		--------------
		{
			"mg979/vim-visual-multi",
			keys = { "<C-n>", { "v", "<C-n>" }, "<C-S-L>", { "v", "<C-S-L>" }, "ma", { "v", "ma" } },
			setup = function()
				require("user.setup.visual-multi").setup()
			end,
			config = function()
				require("user.config.visual-multi").config()
			end,
		},
		{
			"monaqa/dial.nvim",
			config = function()
				require("user.config.dial").config()
			end,
		},
		{
			"dkarter/bullets.vim",
		},
		-- 用于从远程终端复制到本地
		{
			"ojroques/vim-oscyank",
			config = function()
				lvim.builtin.which_key.vmappings["y"] = { ":OSCYank<CR>", "Copy to clipboard(Remote)" }
			end,
		},
		--------------
		-- 普通模式 --
		--------------
		{
			"terryma/vim-expand-region",
			keys = { { "v", "v" }, { "v", "V" } },
			config = function()
				require("user.config.expand-region").config()
			end,
		},
		{
			"kana/vim-textobj-user",
		},
		{
			"kana/vim-textobj-entire",
		},
		{
			"kana/vim-textobj-indent",
		},
		{
			"kana/vim-textobj-line",
		},
		{
			"sgur/vim-textobj-parameter",
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		{ "nvim-treesitter/nvim-treesitter-context" },
		{
			"tpope/vim-repeat",
		},
		{
			"tpope/vim-surround",
			keys = { "c", "d", "y" },
		},
		--------------
		-- 语言服务 --
		--------------
		{
			"j-hui/fidget.nvim",
			event = "BufRead",
			config = function()
				require("user.config.fidget").config()
			end,
		},
		{
			"ray-x/lsp_signature.nvim",
			config = function()
				require("user.config.lsp_signature").config()
			end,
		},
		-- {
		-- 	"benfowler/telescope-luasnip.nvim",
		-- 	keys = { "<M-i>" },
		-- 	config = function()
		-- 		require("user.config.telescope-luasnip").config()
		-- 	end,
		-- },
		-- {
		-- 	"tamago324/cmp-zsh",
		-- 	config = function()
		-- 		require("user.config.cmp_zsh").config()
		-- 	end,
		-- 	requires = { "Shougo/deol.nvim" },
		-- },
		-- {
		-- 	"p00f/clangd_extensions.nvim",
		-- 	ft = { "c", "cpp", "objc", "objcpp" },
		-- 	config = function()
		-- 		require("user.config.clangd_extensions").config()
		-- 	end,
		-- },
		-- {
		-- 	"windwp/nvim-ts-autotag",
		-- },
		{
			"simrat39/rust-tools.nvim",
			config = function()
				require("user.config.rust-tools").config()
			end,
		},
		-- You must install glow globally
		-- https://github.com/charmbracelet/glow
		-- yay -S glow
		{
			"npxbr/glow.nvim",
			ft = { "markdown" },
			run = "yay -S glow",
		},
		-- 文档
		{
			"danymat/neogen",
			config = function()
				require("user.config.neogen").setup()
			end,
			cmd = { "Neogen" },
			module = "neogen",
			disable = false,
		},
		-- 切换 python 虚拟环境
		{
			"AckslD/swenv.nvim",
			config = function()
				require("swenv").setup({
					-- Should return a list of tables with a `name` and a `path` entry each.
					-- Gets the argument `venvs_path` set below.
					-- By default just lists the entries in `venvs_path`.
					get_venvs = function(venvs_path)
						return require("swenv.api").get_venvs(venvs_path)
					end,
					-- Path passed to `get_venvs`.
					venvs_path = vim.fn.expand("~/venvs"),
					-- Something to do after setting an environment
					post_set_venv = nil,
				})
			end,
		},
		-- 清除未使用的库
		{
			"tenfyzhong/autoflake.vim",
			run = "pip install autoflake",
		},
		--------------
		-- 文件操作 --
		--------------
		{
			"lambdalisue/suda.vim",
			cmd = { "SudaRead", "SudaWrite" },
		},
		{
			"folke/persistence.nvim",
			event = "BufReadPre", -- this will only start session saving when an actual file was opened
			module = "persistence",
			config = function()
				require("user.config.persistence").config()
			end,
		},
		--------------
		-- 界面元素 --
		--------------
		{
			"petertriho/nvim-scrollbar",
			config = function()
				require("user.config.scrollbar").config()
			end,
		},
		-- FIXME: 缩略进度条 必须使用命令才会显示，不会自动加载
		{
			"wfxr/minimap.vim",
			run = "cargo install --locked code-minimap",
			cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
			config = function()
				vim.cmd("let g:minimap_width = 10")
				vim.cmd("let g:minimap_auto_start = 1")
				vim.cmd("let g:minimap_auto_start_win_enter = 1")
			end,
		},
		{
			"sidebar-nvim/sidebar.nvim",
			cmd = "Sidebar*",
			config = function()
				require("user.config.sidebar").config()
			end,
		},
		{
			"simrat39/symbols-outline.nvim",
			cmd = "SymbolsOutline*",
			config = function()
				require("user.config.symbols-outline").config()
			end,
		},
		{
			"folke/todo-comments.nvim",
			event = "BufRead",
			config = function()
				require("user.config.todo-comments").config()
			end,
		},
		{
			"mbbill/undotree",
			cmd = { "Undotree*" },
		},
		{
			"folke/trouble.nvim",
			cmd = { "Trouble*" },
			config = function()
				require("user.config.trouble").config()
			end,
		},
		{
			"kevinhwang91/nvim-bqf",
			event = { "BufRead", "BufNew" },
			config = function()
				require("user.config.bqf").config()
			end,
		},
		{
			"stevearc/dressing.nvim",
			event = "BufWinEnter",
			config = function()
				require("user.config.dressing").config()
			end,
		},
		{
			"folke/noice.nvim",
			config = function()
				require("user.config.noice").config()
			end,
			requires = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			},
		},
		--------------
		-- 界面美化 --
		--------------
		{ "p00f/nvim-ts-rainbow" },
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("user.config.colorizer").config()
			end,
		},
		{
			"abzcoding/tokyonight.nvim",
			as = "tokyo-night",
			branch = "feat/local",
			config = function()
				require("user.config.tokyonight").config()
				vim.cmd([[colorscheme tokyonight-moon]])
				lvim.builtin.lualine.options.theme = "tokyonight"
			end,
			cond = function()
				local _time = os.date("*t")
				return _time.hour >= 15 and _time.hour < 24
			end,
		},
		{
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				require("user.config.catppuccin").config()
				vim.cmd([[colorscheme catppuccin]])
				lvim.builtin.lualine.options.theme = "catppuccin"
			end,
			cond = function()
				local _time = os.date("*t")
				return (_time.hour >= 0 and _time.hour < 15)
			end,
		},
		--------------
		-- 其他功能 --
		--------------
		{
			"voldikss/vim-translator",
			cmd = { "Translate*" },
			setup = function()
				require("user.setup.translator").setup()
			end,
		},
		{
			"fedorenchik/VimCalc3",
			cmd = { "Calc" },
		},
		{ "github/copilot.vim", run = ":Copilot setup" },
		{
			"kdheepak/lazygit.nvim",
			config = function()
				require("user.config.telescope-lazygit").config()
			end,
		},
		{
			"nvim-neotest/neotest",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-neotest/neotest-python",
			},
			config = function()
				require("user.config.nvim-neotest").config()
			end,
		},
		{ "tpope/vim-fugitive" },
		{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
		{ "f-person/git-blame.nvim" },
		{ "felipec/vim-sanegx" }, -- FIXME
		-- 统计 coding 时长
		{ "wakatime/vim-wakatime" },
		-- 自动保存
		{
			"Pocco81/auto-save.nvim",
			config = function()
				require("auto-save").setup({
					enabled = true,
				})
			end,
		},
		-- Buffer Jump
		{
			"ghillb/cybu.nvim",
			branch = "main", -- timely updates
			requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
			config = function()
				local ok, cybu = pcall(require, "cybu")
				if not ok then
					return
				end
				cybu.setup()
			end,
		},
		-- 窗口跳转
		{
			"beauwilliams/focus.nvim",
			config = function()
				require("focus").setup()
			end,
		},
		-- Python 虚拟环境
		{
			"jmcantrell/vim-virtualenv",
		},
		-- Session 会话管理
		{

			"olimorris/persisted.nvim",
			--module = "persisted", -- For lazy loading
			config = function()
				require("persisted").setup({
					command = "VimLeavePre",
				})
				require("telescope").load_extension("persisted") -- To load the telescope extension
			end,
		},
	}
end

-- http://www.baidu.com

return M
