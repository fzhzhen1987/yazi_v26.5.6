--- @sync entry
-- 同一排序键按第二次时切换正序/倒序
return {
	entry = function(_, job)
		local by = job.args[1]
		local pref = cx.active.pref
		local reverse = pref.sort_by == by and not pref.sort_reverse
		ya.emit("sort", { by, reverse = reverse })
	end,
}

