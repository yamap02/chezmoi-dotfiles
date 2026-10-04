local M = {}

local function line_count(path)
	local output, err = Command("wc"):arg({ "-l", "--", path }):output()
	if not output then
		return nil, err
	end

	return output.stdout:match("^%s*(%d+)")
end

function M:peek(job)
	local path = tostring(job.file.path)
	local count, count_err = line_count(path)
	local output, content_err = Command("cat"):arg(path):output()
	if not output then
		ya.preview_widget(job, ui.Text(string.format("Unable to preview file: %s", content_err or "unknown error")):
			area(job.area))
		return
	end

	local header = count and string.format("Lines: %s\n\n", count)
		or string.format("Lines: unavailable (%s)\n\n", count_err or "unknown error")
	local text = ui.Text.parse(header .. output.stdout)
	ya.preview_widget(job, text:area(job.area):wrap(ui.Wrap.YES))
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
