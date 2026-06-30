--- @sync entry
-- Smart Enter 插件 (yazi 26.x)
-- 目录 → enter；文件 → open --with edit （走 [opener].edit，即 code -w）

local function entry()
	local h = cx.active.current.hovered
	if h and h.cha.is_dir then
		ya.emit("enter", {})
	else
		ya.emit("open", { hovered = true })
	end
end

return { entry = entry }
