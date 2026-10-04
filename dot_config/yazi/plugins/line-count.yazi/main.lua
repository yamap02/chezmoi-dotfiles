local M = {}

local function line_count(path)
	local output, err = Command("wc"):arg({ "-l", "--", path }):output()
	if not output then
		return nil, err
	end

	return output.stdout:match("^%s*(%d+)")
end

function M:peek(job)
	local count, err = line_count(tostring(job.file.path))
	if not count then
		ya.preview_widget(job, ui.Text(string.format("Unable to count lines: %s", err or "unknown error")):
			area(job.area))
		return
	end

	local header_area = ui.Rect {
		x = job.area.x,
		y = job.area.y,
		w = job.area.w,
		h = math.min(1, job.area.h),
	}
	ya.preview_widget(job, ui.Text(string.format("Lines: %s", count)):area(header_area))

	if job.area.h > 1 then
		ya.preview_code {
			area = ui.Rect {
				x = job.area.x,
				y = job.area.y + 1,
				w = job.area.w,
				h = job.area.h - 1,
			},
			file = job.file,
			mime = job.mime,
			skip = job.skip,
		}
	end
end

function M:seek(job)
	local hovered = cx.active.current.hovered
	if not hovered or hovered.url ~= job.file.url then
		return
	end

	local step = math.floor(job.units * job.area.h / 10)
	step = step == 0 and ya.clamp(-1, job.units, 1) or step
	ya.emit("peek", {
		math.max(0, cx.active.preview.skip + step),
		only_if = job.file.url,
	})
end

return M
