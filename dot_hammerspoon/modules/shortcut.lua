-- 此文件为示例文件，用户请勿修改，如需自定义快捷键，请修改 shortcut.lua 文件，如不存在 shortcut.lua 文件，则执行命令 cp shortcut.lua.example shortcut.lua 创建一份即可
-- 快捷键配置版本号
shortcut_config = {
	version = 1.0,
}

-- prefix：表示快捷键前缀，可选值：Ctrl、Option、Command
-- key：可选值 [A-Z]、[1-9]、Left、Right、Up、Down、-、=、/
-- message 表示提示信息

-- 应用切换快捷键配置
applications = {
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "W", message = "WeChat", bundleId = "com.tencent.xinWeChat" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "V", message = "VSCode", bundleId = "com.microsoft.VSCode" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "E", message = "Finder", bundleId = "com.apple.finder" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "C", message = "Chrome", bundleId = "com.google.Chrome" },
	{
		prefix = { "ctrl", "alt", "cmd", "shift" },
		key = "D",
		message = "DataGrip",
		bundleId = "com.jetbrains.datagrip",
	},
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "P", message = "PyCharm", bundleId = "com.jetbrains.pycharm" },
	{
		prefix = { "ctrl", "alt", "cmd", "shift" },
		key = "J",
		message = "Jump Desktop",
		bundleId = "com.p5sys.jump.mac.viewer",
	},
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "T", message = "Teams", bundleId = "com.microsoft.teams" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "O", message = "Outlook", bundleId = "com.microsoft.Outlook" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "N", message = "Obsidian", bundleId = "md.obsidian" },
}

