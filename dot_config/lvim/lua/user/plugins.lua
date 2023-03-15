local M = {}

M.config = function()
	lvim.plugins = {
		--------------
		-- 屏幕滚动 --
		--------------
		-- 用于在屏幕上滚动的插件
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
		-- 增强 f/F/t/T 功能
		{
			"rhysd/clever-f.vim",
			keys = { "f", "F", "t", "T" },
			setup = function()
				require("user.setup.clever-f").setup()
			end,
		},
		-- 用于快速跳转到指定位置
		{
			"phaazon/hop.nvim",
			cmd = "Hop*",
			config = function()
				require("user.config.hop").config()
			end,
		},
		-- 用于快速跳转到指定位置
		{
			"ggandor/leap.nvim",
			event = "BufRead",
			keys = { "s", "S" },
			config = function()
				require("user.config.leap-nvim").config()
			end,
		},
		-- 增强 '%' 的匹配功能
		{
			"andymass/vim-matchup",
			event = "CursorMoved",
			setup = function()
				require("user.setup.matchup").setup()
			end,
		},
		-- 在非跳转下，查看目标行
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
		-- 用于标记标签和快速跳转
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
		-- 预览代码
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
			end,
		},
		--------------
		-- 全文搜索 --
		--------------
		-- visual 下选中的部分用于快速搜索
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
		-- 累加/累减
		{
			"monaqa/dial.nvim",
			config = function()
				require("user.config.dial").config()
			end,
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
			"Julian/vim-textobj-variable-segment",
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		-- 使用 . 重复上一次的操作
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
		{
			"windwp/nvim-ts-autotag",
		},
		{
			"simrat39/rust-tools.nvim",
			config = function()
				require("user.config.rust-tools").config()
			end,
		},
		-- Markdown 渲染工具
		{
			"npxbr/glow.nvim",
			ft = { "markdown" },
			run = "yay -S glow",
		},
		-- 为函数/方法/类生成接口文档
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
		-- Python 清除未使用的库
		{
			"tenfyzhong/autoflake.vim",
			ft = { "python", "py", "pyi" },
			run = "pip install autoflake",
		},
		-- Python 清除多余的空格
		-- resovle: https://github.com/mkdir700/dotfiles/issues/4
		{
			"Vimjas/vim-python-pep8-indent",
			config = function()
				vim.g.python_pep8_indent = 1
			end,
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
		-- 上下文展示
		{ "nvim-treesitter/nvim-treesitter-context" },
		--------------
		-- 界面美化 --
		--------------
		{ "p00f/nvim-ts-rainbow" },
		-- 主题
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("user.config.colorizer").config()
			end,
		},
		{
			"loctvl842/monokai-pro.nvim",
			config = function()
				require("user.config.monokai-pro").config()
				vim.cmd([[colorscheme monokai-pro]])
			end,
			cond = function()
				local _time = os.date("*t")
				return _time.hour >= 15 and _time.hour < 24
			end,
		},
		-- {
		-- 	"abzcoding/tokyonight.nvim",
		-- 	as = "tokyo-night",
		-- 	branch = "feat/local",
		-- 	config = function()
		-- 		require("user.config.tokyonight").config()
		-- 		vim.cmd([[colorscheme tokyonight-moon]])
		-- 		lvim.builtin.lualine.options.theme = "tokyonight"
		-- 	end,
		-- 	cond = function()
		-- 		local _time = os.date("*t")
		-- 		return _time.hour >= 15 and _time.hour < 24
		-- 	end,
		-- },
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
		-- {
		-- 	"echasnovski/mini.animate",
		-- 	config = function()
		-- 		require("mini.animate").setup()
		-- 	end,
		-- },
		-- {
		-- 	"echasnovski/mini.cursorword",
		-- 	config = function()
		-- 		require("mini.cursorword").setup()
		-- 	end,
		-- },
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
		-- 自动切换输入法
		-- 需要安装 https://github.com/daipeihust/im-select
		{
			"keaising/im-select.nvim",
			config = function()
				require("user.config.im-select").config()
			end,
		},
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
		{
			"rafi/vim-venom",
			ft = { "python" },
			config = function()
				require("venom").setup()
				-- 重启 LSP 服务后生效
				vim.cmd([[ LspRestart ]])
			end,
		},
    -- Enhanced gF command for Python
		{
			"sychen52/gF-python-traceback",
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
		-- AI 代码补全
		-- { "github/copilot.vim", run = ":Copilot setup" },
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("user.config.copilot").config()
			end,
		},
		-- {
		-- 	"zbirenbaum/copilot-cmp",
		-- 	after = { "copilot.lua" },
		-- 	config = function()
		-- 		require("copilot_cmp").setup()
		-- 	end,
		-- },
		{
			"jackMort/ChatGPT.nvim",
			config = function()
				require("chatgpt").setup({})
			end,
			requires = {
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
			},
		},
	}
end

return M
