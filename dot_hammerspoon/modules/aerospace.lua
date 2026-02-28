-- ~/.hammerspoon/aerospace.lua
local M = {}

-- ====== 可调常量 ======
local MARKER_START = "# ===== HS-MANAGED-FLOAT RULES START ====="
local MARKER_END = "# ===== HS-MANAGED-FLOAT RULES END ====="

-- ====== 工具函数 ======
local function fileExists(path)
	return path and hs.fs.attributes(path) ~= nil
end

local function readFile(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local s = f:read("*a")
	f:close()
	return s
end

local function writeFile(path, s)
	local f = assert(io.open(path, "w"))
	f:write(s)
	f:close()
end

local function defaultAerospaceBin()
	-- 常见 Homebrew 路径；如不同可在 opts.bin 传入
	local candidates = {
		"/opt/homebrew/bin/aerospace",
		"/usr/local/bin/aerospace",
		"aerospace", -- 走 PATH
	}
	for _, p in ipairs(candidates) do
		local t = hs.task.new("/usr/bin/env", nil, { "bash", "-lc", "command -v " .. p .. " >/dev/null 2>&1" })
		if t then
			t:start()
			t:waitUntilExit()
			if t:terminationStatus() == 0 then
				if p == "aerospace" then
					-- 解析绝对路径
					local pipe = io.popen("command -v aerospace 2>/dev/null")
					local resolved = pipe and pipe:read("*l") or nil
					if pipe then
						pipe:close()
					end
					if resolved and #resolved > 0 then
						return resolved
					end
				else
					return p
				end
			end
		end
	end
	return "aerospace" -- 兜底走 PATH
end

local function defaultConfigPath()
	local xdg = os.getenv("XDG_CONFIG_HOME")
	if xdg and #xdg > 0 then
		local p = xdg .. "/aerospace/aerospace.toml"
		if fileExists(p) then
			return p
		end
	end
	local home = os.getenv("HOME") or ""
	local p2 = home .. "/.config/aerospace/aerospace.toml"
	if fileExists(p2) then
		return p2
	end
	return home .. "/.aerospace.toml"
end

local function run(bin, args)
	local t = hs.task.new(bin, nil, args)
	if not t then
		return false
	end
	t:start()
	return true
end

-- 将 Lua 模式字符转义为“字面量”正则子串（给 window-title-regex-substring 用）
local function escapeForRegexSubstring(s)
	-- 把常见正则元字符做转义：^$()%.[]*+-?|
	return (s or ""):gsub("([%^%$%(%)%%%.%[%]%*%+%-%?%|])", "%%%1")
end

-- 确保 HS 托管块存在，并在 END 标记前插入 tpl
local function insertRuleToManagedBlock(cfg, tpl)
	if not cfg:find(MARKER_START, 1, true) then
		cfg = cfg .. "\n\n" .. MARKER_START .. "\n" .. MARKER_END .. "\n"
	end
	local before, after = cfg:match("^(.*)" .. MARKER_END .. "(.*)$")
	if before and after then
		return before .. tpl .. "\n" .. MARKER_END .. after
	else
		-- 理论不该走到这里，兜底直接末尾追加
		return cfg .. tpl
	end
end

local function ensureRule(configPath, needlePattern, tpl)
	local cfg = readFile(configPath) or ""
	if cfg:find(needlePattern) then
		return false, "rule-exists"
	end
	local newCfg = insertRuleToManagedBlock(cfg, tpl)
	writeFile(configPath, newCfg)
	return true, "added"
end

local function effectiveBin(opts)
	return (opts and opts.bin) or defaultAerospaceBin()
end

local function effectiveConfig(opts)
	return (opts and opts.configPath) or defaultConfigPath()
end

local function boolOpt(opts, key, default)
	if type(opts) == "table" and opts[key] ~= nil then
		return not not opts[key]
	end
	return default
end

local function applyCurrentFloatingIfNeeded(bin, apply)
	if not apply then
		return
	end
	-- 只对当前焦点窗口发一次“浮动”命令；失败也不报错
	run(bin, { "layout", "floating" })
end

local function reloadIfNeeded(bin, reload)
	if not reload then
		return
	end
	run(bin, { "reload-config", "--no-gui" })
end

-- ====== 对外函数：按 appId 追加浮动规则 ======
function M.addFloatRuleForApp(appId, opts)
	if not appId or #appId == 0 then
		return false, "invalid-appId"
	end
	local bin = effectiveBin(opts)
	local cfgPath = effectiveConfig(opts)
	local tpl = string.format("\n[[on-window-detected]]\nif.app-id = '%s'\nrun = \"layout floating\"\n", appId)

	-- 匹配存在性（避免重复）：if.app-id = 'xxx'
	local needle = "if%.app%-id%s*=%s*['\"]" .. appId:gsub("([%%%^%$%(%)%.%[%]%*%+%-%?])", "%%%1") .. "['\"]"

	local ok, why = ensureRule(cfgPath, needle, tpl)
	if ok then
		applyCurrentFloatingIfNeeded(bin, boolOpt(opts, "applyCurrent", true))
		reloadIfNeeded(bin, boolOpt(opts, "reload", true))
	end
	return ok, why
end

-- ====== 对外函数：按窗口标题“子串”追加浮动规则 ======
function M.addFloatRuleForTitle(titleSubstring, opts)
	if not titleSubstring or #titleSubstring == 0 then
		hs.alert.show("invalid titleSubstring: " .. tostring(titleSubstring))
		return false, "invalid-title"
	end
	local bin = effectiveBin(opts)
	local cfgPath = effectiveConfig(opts)

	local pattern = escapeForRegexSubstring(titleSubstring)
	hs.alert.show("Pattern = " .. pattern) -- 调试用

	local tpl = string.format(
		"\n[[on-window-detected]]\nif.window-title-regex-substring = '%s'\nrun = \"layout floating\"\n",
		pattern
	)

	local needle = "if%.window%-title%-regex%-substring%s*=%s*['\"]" .. pattern .. "['\"]"

	local ok, why = ensureRule(cfgPath, needle, tpl)
	if ok then
		applyCurrentFloatingIfNeeded(bin, boolOpt(opts, "applyCurrent", true))
		reloadIfNeeded(bin, boolOpt(opts, "reload", true))
	end
	return ok, why
end

-- ====== 辅助：导出探测到的路径（便于调试/显示） ======
function M.resolvePaths(opts)
	return {
		bin = effectiveBin(opts),
		configPath = effectiveConfig(opts),
	}
end

return M
