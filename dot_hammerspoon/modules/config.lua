-- 默认加载的功能模块
defaultConfig = {
	{
		-- 配置版本号
		-- 每次新增功能项，需将版本号加 1
		configVersion = "6",
	},
	{
		module = "modules.application",
		name = "应用切换",
		enable = true,
	},
	{
		module = "modules.keystroke-visualizer",
		name = "按键回显",
		enable = true,
	},
	{
		module = "modules.update",
		name = "自动检查更新",
		enable = false,
	},
}

base_path = os.getenv("HOME") .. "/.hammerspoon/"
-- 本地配置文件路径
config_path = base_path .. ".config"

-- 加载本地配置文件
function loadConfig()
	-- 以可读写方式打开文件
	local file = io.open(config_path, "r+")
	-- 文件不存在
	if file == nil then
		-- 创建文件
		file = io.open(config_path, "w+")
	end
	-- 读取文件所有内容
	local config = file:read("*a")
	-- 配置文件中不存在配置
	if config == "" then
		-- 读取默认配置
		config = serialize(defaultConfig)
	end
	file:close()
	return config
end

function saveConfig(config)
	-- 清空文件内容，然后写入新的文件内容
	file = io.open(config_path, "w+")
	file:write(serialize(config))
	file:close()
end
