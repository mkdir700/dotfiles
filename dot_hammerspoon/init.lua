local aero = require("modules.aerospace")

-- 🔔 辅助函数：打印通知
local function notify(title, msg)
	hs.alert.show(msg)
	hs.notify.new({ title = title, informativeText = msg }):send()
end

-- 维护被 Pin 的窗口（通过周期性 raise 保持前置）
local pinnedWindowIds = {}
local pinTimer = nil

local function pinnedCount()
	local n = 0
	for _ in pairs(pinnedWindowIds) do
		n = n + 1
	end
	return n
end

local function refreshPinnedWindows()
	for id in pairs(pinnedWindowIds) do
		local win = hs.window.get(id)
		if not win or win:isMinimized() then
			pinnedWindowIds[id] = nil
		else
			win:raise()
		end
	end

	if pinnedCount() == 0 and pinTimer then
		pinTimer:stop()
		pinTimer = nil
	end
end

local function ensurePinTimer()
	if pinTimer then
		return
	end
	pinTimer = hs.timer.doEvery(0.2, refreshPinnedWindows)
end

-- 辅助函数：切换显示/隐藏
local function toggleApp(bundleId, message)
	local app = hs.application.get(bundleId)
	if app and app:isFrontmost() then
		-- 如果在前台，就隐藏
		app:hide()
		hs.alert.show(message .. "(hidden)")
	else
		-- 否则就激活/打开
		hs.application.launchOrFocusByBundleID(bundleId)
		hs.alert.show(message .. "(shown)")
	end
end

local applications = {
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "A", message = "ChatGPT", bundleId = "com.openai.chat" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "W", message = "WeChat", bundleId = "com.tencent.xinWeChat" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "V", message = "VSCode", bundleId = "com.microsoft.VSCode" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "E", message = "Finder", bundleId = "com.apple.finder" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "C", message = "Chrome", bundleId = "com.google.Chrome" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "N", message = "Obsidian", bundleId = "md.obsidian" },
	{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "K", message = "Kitty", bundleId = "com.mitchellh.ghostty" },
}

-- 注册快捷键
for _, app in ipairs(applications) do
	hs.hotkey.bind(app.prefix, app.key, function()
		toggleApp(app.bundleId, app.message)
	end)
end

-- 🔄 重新加载 Hammerspoon 配置（快捷键：ctrl+alt+cmd+shift+R）
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "R", function()
	hs.reload()
	notify("Hammerspoon", "配置已重新加载 ✅")
end)

-- ① 按 bundleId 记忆浮动（当前焦点窗口所在 App）
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "F", function()
	local win = hs.window.focusedWindow()
	if not win then
		hs.alert.show("未找到焦点窗口")
		return
	end
	local app = win:application()
	if not app then
		hs.alert.show("未获取到应用")
		return
	end
	local appId = app:bundleID()
	local ok, why = aero.addFloatRuleForApp(appId, {
		-- bin = "/opt/homebrew/bin/aerospace",
		-- configPath = os.getenv("HOME").."/.config/aerospace/aerospace.toml",
		reload = true,
		applyCurrent = true,
	})
	hs.alert.show(ok and ("已追加浮动规则: " .. appId) or ("未追加: " .. tostring(why)))
end)

-- ② 按“标题子串”记忆浮动（当前焦点窗口的标题）
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "Y", function()
	local win = hs.window.focusedWindow()
	if not win then
		hs.alert.show("未找到焦点窗口")
		return
	end
	local title = win:title() or ""
	if #title == 0 then
		hs.alert.show("未获取到窗口标题")
		return
	end
	local ok, why = aero.addFloatRuleForTitle(title, {
		reload = true,
		applyCurrent = true,
	})
	hs.alert.show(ok and "已按标题追加浮动规则" or ("未追加: " .. tostring(why)))
end)

-- ③ Pin/Unpin 当前窗口到最上层（近似实现：持续 raise）
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "P", function()
	local win = hs.window.focusedWindow()
	if not win then
		hs.alert.show("未找到可 Pin 的焦点窗口")
		return
	end

	local id = win:id()
	if not id then
		hs.alert.show("当前窗口不支持 Pin")
		return
	end

	if pinnedWindowIds[id] then
		pinnedWindowIds[id] = nil
		hs.alert.show("已取消置顶")
		if pinnedCount() == 0 and pinTimer then
			pinTimer:stop()
			pinTimer = nil
		end
		return
	end

	pinnedWindowIds[id] = true
	win:raise()
	ensurePinTimer()
	hs.alert.show("已置顶（再次按下可取消）")
end)

-- ⑤ warpd normal mode: F17 (from Karabiner right_option tap)
hs.hotkey.bind({}, "f17", function()
	hs.task.new("/usr/local/bin/warpd", nil, { "--normal" }):start()
end)

-- ④ warpd trigger: F18 (from Karabiner right_command tap) → hint2 + auto click
-- Click is fired by Hammerspoon *after* warpd exits, to dodge warpd's
-- CGEventGetLocation race (--click lands at the pre-move cursor position).
hs.hotkey.bind({}, "f18", function()
	local task = hs.task.new("/usr/local/bin/warpd", function(exitCode)
		if exitCode == 0 then
			hs.timer.doAfter(0.02, function()
				hs.eventtap.leftClick(hs.mouse.absolutePosition())
			end)
		end
	end, { "--hint2", "--oneshot" })
	task:start()
end)

notify("Hammerspoon", "配置加载完成")
