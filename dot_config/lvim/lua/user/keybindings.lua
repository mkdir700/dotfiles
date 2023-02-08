local M = {}

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.config = function()
	--------------
	-- 屏幕(screen)滚动 --
	--------------
	-- plugin: neoscroll.nvim
	--------------------
	-- 会话持久化管理 --
	--------------------
	lvim.builtin.which_key.mappings.s.s = {
		":Telescope persisted<CR>",
		"View Sessions",
	}
	lvim.builtin.which_key.mappings["S"] = {
		name = "会话管理",
		l = { "<CMD>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
		c = { "<CMD>lua require('persistence').load()<cr>", "Restore last session for current dir" },
		q = { "<CMD>lua require('persistence').stop()<cr>", "Quit without saving session" },
		s = { ":Telescope persisted<CR>", "View Sessions" },
	}

	--------------
	-- 终端(terminal)管理 --
	--------------
	map("t", "<C-q>[", "<C-\\><C-n>")
	map("t", "<S-Esc>", "<C-\\><C-n>")
	map("t", "<C-h>", "<BS>")
	map("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
	-- map("t", "<C-k>", "<ESC>d$a<BS><BS>")

	--------------
	-- 窗口(widnows)管理 --
	--------------
	map("n", "<M-K>", ":resize +2<CR>")
	map("n", "<M-J>", ":resize -2<CR>")
	map("n", "<M-]>", ":vertical resize -2<CR>")
	map("n", "<M-[>", ":vertical resize +2<CR>")
	map("n", "_", ":sp<CR>")
	map("n", "|", ":vsp<CR>")
	vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })

	--------------
	-- 光标(cursor)移动 --
	--------------
	-- plugin: clever-f.vim
	-- plugin: hop.nvim
	-- plugin: vim-matchup
	-- plugin: leap.vim
	map("c", "<C-a>", "<C-b>", { noremap = true })
	map("n", ";", "<CMD>HopChar2<CR>", { silent = true })
	map("n", ",", "<CMD>HopLineStartMW<CR>", { silent = true })
	map("i", "<C-f>", "<Right>")
	map("i", "<C-b>", "<Left>")

	--------------
	-- 标签跳转 --
	--------------
	-- plugin: nvim-lastplace
	-- plugin: vim-bookmarks
	-- plugin: telescope-vim-bookmarks
	-- HACK: terminal map: ctrl+i -> alt+shift+i
	map("n", "<C-i>", "<C-i>", { silent = true })
	map("i", "<C-a>", "<C-[>I") -- 编辑状态下，快速移动至头部
	map("i", "<C-e>", "<C-[>A") -- 编辑状态下，快速移动至尾部
	map("n", "mm", "<Plug>BookmarkToggle", { noremap = false })
	map("n", "mi", "<Plug>BookmarkAnnotate", { noremap = false })
	map("n", "mn", "<Plug>BookmarkNext", { noremap = false })
	map("n", "mp", "<Plug>BookmarkPrev", { noremap = false })
	map("n", "mc", "<Plug>BookmarkClear", { noremap = false })
	map("n", "mC", "<Plug>BookmarkClearAll", { noremap = false })
	map("n", "mjj", "<Plug>BookmarkMoveDown", { noremap = false })
	map("n", "mkk", "<Plug>BookmarkMoveUp", { noremap = false })
	map("n", "mg", "<Plug>BookmarkMoveToLine", { noremap = false })
	map("n", "]g", "<CMD>Gitsigns next_hunk<CR>")
	map("n", "[g", "<CMD>Gitsigns prev_hunk<CR>")
	-- 测试用例跳转
	map(
		"n",
		"]n",
		"<CMD>lua require('neotest').jump.next({ status = 'failed' })<CR>",
		{ desc = "Next failed testcase", silent = true }
	)
	map(
		"n",
		"[n",
		"<CMD>lua require('neotest').jump.prev({ status = 'failed' })<CR>",
		{ desc = "Previous failed testcase", silent = true }
	)
	-- Todo 标签跳转
	map("n", "]t", "<CMD>lua require('todo-comments').jump_next()<CR>", { desc = "Next todo comments" })
	map("n", "[t", "<CMD>lua require('todo-comments').jump_prev()<CR>", { desc = "Previous todo comments" })
	-- 缓冲区(buffer)跳转
	map("n", "[b", "<Plug>(CybuPrev)", { desc = "Next buffer", silent = true })
	map("n", "]b", "<Plug>(CybuNext)", { desc = "Previous buffer", silent = true })
	map("n", "[e", "<CMD>lua vim.diagnostic.goto_prev()<CR>")
	map("n", "]e", "<CMD>lua vim.diagnostic.goto_next()<CR>")
	vim.keymap.set({ "n", "v" }, "<M-Tab>", "<plug>(CybuLastusedPrev)")
	vim.keymap.set({ "n", "v" }, "<M-S-Tab>", "<plug>(CybuLastusedNext)")

	--------------
	-- 全文搜索 --
	--------------
	-- plugin: vim-visual-star-search
	-- plugin: vim-cool
	-- plugin: telescope-live-grep-raw.nvim
	-- plugin: nvim-spectre
	map("n", "n", "'Nn'[v:searchforward]", { expr = true })
	map("n", "N", "'nN'[v:searchforward]", { expr = true })
	map("n", "<M-l>", "<CMD>nohl<CR><C-l>")
	map("c", "<M-W>", "\\<\\><Left><Left>")
	map("c", "<M-r>", "\\v")
	map("c", "<M-c>", "\\C")
	map("n", "<C-f>", "<CMD>Telescope current_buffer_fuzzy_find<CR>")
	map("v", "<C-f>", "y<ESC>:Telescope current_buffer_fuzzy_find default_text=<c-r>0<CR>")
	map("n", "<C-s>", "<CMD>Telescope lsp_document_symbols<CR>")
	map("v", "<C-s>", "y<ESC>:Telescope lsp_document_symbols default_text=<c-r>0<CR>")
	map("n", "<C-t>", "<CMD>Telescope lsp_workspace_symbols<CR>")
	map("v", "<C-t>", "y<ESC>:Telescope lsp_workspace_symbols default_text=<c-r>0<CR>")
	lvim.builtin.which_key.vmappings.s = {
		name = "Search",
		f = { "y<ESC>:Telescope find_files default_text=<c-r>0<CR>", "Find File" },
		h = { "y<ESC>:Telescope help_tags default_text=<c-r>0<CR>", "Find Help" },
		R = { "y<ESC>:Telescope registers default_text=<c-r>0<CR>", "Registers" },
		t = { "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", "Text" },
		k = { "y<ESC>:Telescope keymaps default_text=<c-r>0<CR>", "Keymaps" },
		C = { "y<ESC>:Telescope commands default_text=<c-r>0<CR>", "Commands" },
	}
	lvim.builtin.which_key.mappings.s.n = { ":Telescope notify<CR>", "Notify" }

	--------------
	-- 快速编辑(Edit) --
	--------------
	-- plugin: vim-visual-multi
	map("i", "jk", "<C-[>")
	map("n", ">", ">>")
	map("n", "<", "<<")
	map("i", "<C-S-J>", "<CMD>m .+1<CR><Cmd>normal ==<CR>")
	map("n", "<C-S-J>", "<CMD>m .+1<CR><Cmd>normal ==<CR>")
	map("i", "<C-S-K>", "<CMD>m .-2<CR><Cmd>normal ==<CR>")
	map("n", "<C-S-K>", "<CMD>m .-2<CR><Cmd>normal ==<CR>")
	map("i", "<C-k>", "repeat('<Del>', strchars(getline('.')) - getcurpos()[2] + 1)", { expr = true })
	map("c", "<C-k>", "repeat('<Del>', strchars(getcmdline()) - getcmdpos() + 1)", { expr = true })
	-- 向右边跳转一个单词
	-- map("n", "<C-l>", "<CMD>call C_Right()<CR><Right>")
	map("c", "<C-l>", "<C-Right>")
	map("i", "<C-z>", "<CMD>undo<CR>")
	map("i", "<c-s-z>", "<cmd>redo<cr>")
	map("v", "L", "$")
	map("v", "H", "^")
	map("o", "L", "$")
	map("o", "H", "^")
	-- 输入模式下 Shift + Enter 在当前行下面插入新行
	map("i", "<S-Enter>", "<Esc>o")
	-- Copilot
	map("i", "<S-Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

	--------------
	-- 普通模式 --
	--------------
	-- plugin: vim-expand-region
	-- plugin: vim-textobj-user
	-- plugin: vim-textobj-entire
	-- plugin: vim-textobj-indent
	-- plugin: vim-textobj-line
	-- plugin: vim-textobj-parameter
	-- plugin: nvim-treesitter-textobjects
	-- plugin: vim-repeate
	-- plugin: vim-surround
	-- map("n", "S", "i<CR><Esc>")

	--------------
	-- 复制粘贴 --
	--------------
	-- map("i", "<C-v>", "<C-r>+")
	map("n", "Y", "y$")
	map("v", "=p", '"0p')
	map("n", "=p", '"0p')
	map("n", "=P", '"0P')
	map("n", "=o", "<CMD>put =@0<CR>")
	map("n", "=O", "<CMD>put! =@0<CR>")
	map("v", "<Space>y", '"+y')
	map("v", "<Space>p", '"+p')
	lvim.builtin.which_key.mappings["o"] = { "<CMD>put =@+<CR>", "Paste Clipboard to Next Line" }
	lvim.builtin.which_key.mappings["O"] = { "<CMD>put! =@+<CR>", "Paste Clipboard to Previous Line" }
	lvim.builtin.which_key.mappings["by"] = { "<CMD>%y +<CR>", "Yank Whole Buffer to Clipboard" }
	lvim.builtin.which_key.mappings["bp"] = { '<CMD>%d<CR>"+P', "Patse Clipboard to Whole Buffer" }
	-- lvim.builtin.which_key.mappings["<Space>"] = { "<CMD>let @+ = @0<CR>", "Copy Register 0 to Clipboard" }
	-- lvim.builtin.which_key.mappings["y"] = { '"+y', "Yank to Clipboard" }
	-- lvim.builtin.which_key.mappings["Y"] = { '"+y$', "Yank All Right to Clipboard" }
	-- lvim.builtin.which_key.mappings["p"] = { '"+p', "Paste Clipboard After Cursor" }
	-- lvim.builtin.which_key.mappings["P"] = { '"+P', "Paste Clipboard Before Cursor" }

	--------------
	-- 语言服务 --
	--------------
	-- plugin: fidget.nvim
	-- plugin: lsp_signature.nvim
	-- plugin: telescope-luasnip.nvim
	-- plugin: clangd_extensions.nvim
	-- plugin: nvim-ts-qutotag
	lvim.builtin.cmp.confirm_opts.select = true
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lccm = require("lvim.core.cmp").methods
	lvim.builtin.cmp.mapping = cmp.mapping.preset.insert({
		["<C-f>"] = nil,
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm(lvim.builtin.cmp.confirm_opts)
			else
				fallback()
			end
		end),
		["<Tab>"] = cmp.mapping(function(fallback)
			-- local copilot_keys = vim.fn["copilot#Accept"]()
			if cmp.visible() then
				if luasnip.expandable() and cmp.get_active_entry() == nil then
					cmp.confirm(lvim.builtin.cmp.confirm_opts)
				end
			elseif luasnip.expandable() then
				luasnip.expand({})
			elseif lccm.jumpable() then
				luasnip.jump(1)
			elseif lccm.check_backspace() then
				fallback()
			-- elseif copilot_keys ~= "" and type(copilot_keys) == "string" then
			-- 	vim.api.nvim_feedkeys(copilot_keys, "i", true)
			-- elseif lccm.is_emmet_active() then
			-- 	return vim.fn["cmp#complete"]()
			else
				fallback()
			end
		end, { "i", "s" }),
	})

	map("n", "<M-F>", '<CMD>lua require("lvim.lsp.utils").format({timeout_ms= 2000})<CR>')
	map("i", "<M-F>", '<CMD>lua require("lvim.lsp.utils").format({timeout_ms= 2000})<CR>')
	map("n", "<F2>", "<CMD>lua vim.lsp.buf.rename()<CR>")
	-- 给出代码建议
	map("n", "<M-.>", "<CMD>lua vim.lsp.buf.code_action()<CR>")
	-- 代码注释
	map("n", "<C-_>", "gccj", { noremap = false })
	map("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { noremap = false })
	map("i", "<C-_>", "<CMD>normal gcc<CR>")
	-- 使用 Trouble 插件展示引用信息
	map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
	-- 为函数添加注释
	lvim.builtin.which_key.mappings.l.g = { "<CMD>Neogen func<CR>", "Func Doc" }
	-- 为类添加注释
	lvim.builtin.which_key.mappings.l.G = { "<CMD>Neogen class<CR>", "Class Doc" }
	-- lvim.builtin.which_key.mappings.l.x = { "<cmd>TroubleToggle<cr>", "Trouble", { silent = true, noremap = true } }
	-- 展示当前文件的问题
	lvim.builtin.which_key.mappings.l.x =
		{ "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble", { silent = true, noremap = true } }
	-- 展示当前工作区的问题
	lvim.builtin.which_key.mappings.l.X =
		{ "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble", { silent = true, noremap = true } }
	-- vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
	--   {silent = true, noremap = true}
	-- )
	-- vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
	--   {silent = true, noremap = true}
	-- )

	--------------
	-- 文件(File)操作 --
	--------------
	-- plugin: suda.vim
	-- plugin: persistence.nvim
	-- lvim.keys.normal_mode["<C-k>"] = false
	map("n", "<Tab>", "<CMD>wincmd w<CR>")
	map("n", "<S-Tab>", "<CMD>wincmd W<CR>")
	lvim.builtin.which_key.mappings["k"] = {
		name = "文件操作",
		n = { "<CMD>enew<CR>", "新建文件" },
		o = { "<CMD>Telescope oldfiles<CR>", "老(最近)文件" },
		f = { "<CMD>Telescope find_files<CR>", "查找当前目录下的文件" },
		r = { ":e <C-r>=fnamemodify(expand('%:p'), ':p:h')<CR>/", "重命名文件" },
		p = { "<CMD>Telescope projects<CR>", "最近打开的项目" },
		s = {
			name = "保存",
			s = { "<CMD>SudaWrite<CR>", "超级权限写" },
			a = { "<CMD>wa<CR>", "保存全部文件" },
			o = { ":saveas <C-r>=fnamemodify('.',':p')<CR>", "另存为" },
		},
		-- u = { ":try | %bd | catch | endtry<CR>", "try" }
	}
	lvim.builtin.which_key.mappings["q"] = { "<CMD>call SmartClose()<CR>", "退出" }
	lvim.builtin.which_key.mappings["Q"] = { "<CMD>qa<CR>", "直接退出" }

	--------------
	-- 界面元素 --
	--------------
	-- plugin: dressing.nvim
	-- plugin: nvim-scrollbar
	-- plugin: sidebar.nvim
	-- plugin: symbols-outline.nvim
	-- plugin: todo-comments.nvim
	-- plugin: undotree
	-- plugin: trouble.nvim
	-- plugin: nvim-bqf
	-- map("n", "<C-M-E>", "<CMD>NvimTreeFindFile<CR>")
	-- map("n", "<C-S-U>", "<CMD>lua require('telescope').extensions.notify.notify()<CR>")
	lvim.builtin.which_key.mappings["a"] = {
		name = "Application",
		o = { "<CMD>SymbolsOutline<CR>", "Outline" },
		t = { "<CMD>TodoTrouble<CR>", "TODO" },
		u = { "<CMD>UndotreeToggle<CR>", "UndoTree" },
		c = { "<CMD>Calc<CR>", "Calculator" },
		i = { "<CMD>Autoflake --remove-all-unused-imports<CR>", "AutoFlake" },
    g = { "<CMD>ChatGPT<CR>", "ChatGPT" },
	}
	lvim.builtin.which_key.vmappings.a = {
		name = "Application",
	}
	lvim.builtin.which_key.mappings["E"] = { "<CMD>NvimTreeFocus<CR>", "Explorer Focus" }

	--------------
	-- 其他按键 --
	--------------
	-- map("n", "<M-z>", "<CMD>let &wrap=!&wrap<CR>")
	-- map("n", "<M-t>", "<CMD>TranslateW<CR>")
	-- map("v", "<M-t>", ":TranslateW<CR>")
	-- map("n", "<M-T>", "<CMD>TranslateR<CR>")
	-- map("v", "<M-T>", ":TranslateR<CR>")
	-- map("n", "<C-k><C-s>", "<CMD>Telescope keymaps<CR>")
	map("n", "<M-e>", "<CMD>NvimTreeToggle<CR>")
	map("n", "<C-S-P>", "<CMD>Telescope commands<CR>")
	lvim.builtin.which_key.mappings[";"] = nil
	lvim.builtin.which_key.mappings["/"] = nil
	lvim.builtin.which_key.mappings["h"] = nil
	lvim.builtin.which_key.mappings["e"] = nil -- FIXME: 没有效果

	vim.cmd([[
function! C_Right() abort
  let left_text = getline('.')[getcurpos()[2]-1:]
  if left_text =~ '^\W*\s+$'
    normal $ge
  elseif left_text =~ '^\W*$'
    normal $
  else
    normal e
  endif
endf
function! SmartClose() abort
  if &bt ==# 'nofile' || &bt ==# 'quickfix'
    quit
    return
  endif
  let num = winnr('$')
  for i in range(1, num)
    let buftype = getbufvar(winbufnr(i), '&buftype')
    if buftype ==# 'quickfix' || buftype ==# 'nofile'
      let num = num - 1
    elseif getwinvar(i, '&previewwindow') == 1 && winnr() !=# i
      let num = num - 1
    endif
  endfor
  if num == 1
    if len(getbufinfo({'buflisted':1,'bufloaded':1,'bufmodified':1})) > 0
      echohl WarningMsg
      echon 'There are some buffer modified! Quit/Save/Cancel'
      let rs = nr2char(getchar())
      echohl None
      if rs ==? 'q'
        qall!
      elseif rs ==? 's' || rs ==? 'w'
        redraw
        wall
        qall
      else
        redraw
        echohl ModeMsg
        echon 'canceled!'
        echohl None
      endif
    else
      qall
    endif
  else
    quit
  endif
endf

function! Open_file_in_explorer() abort
  if has('win32') || has('wsl')
    call jobstart('explorer.exe .')
  elseif has('unix')
    call jobstart('xdg-open .')
  endif
endf
]])
end

function M.zoom_current_window()
	local cur_win = vim.api.nvim_get_current_win()
	vim.api.nvim_set_var("non_float_total", 0)
	vim.cmd("windo if &buftype != 'nofile' | let g:non_float_total += 1 | endif")
	vim.api.nvim_set_current_win(cur_win or 0)
	if vim.api.nvim_get_var("non_float_total") == 1 then
		if vim.fn.tabpagenr("$") == 1 then
			return
		end
		vim.cmd("tabclose")
	else
		local last_cursor = vim.api.nvim_win_get_cursor(0)
		vim.cmd("tabedit %:p")
		vim.api.nvim_win_set_cursor(0, last_cursor)
	end
end

return M
