---@class wurm.History
---@field paused boolean
---@field windows table
local M = {
	paused = false,
	windows = {},
}

---@param win integer
---@param buf integer
function M:push(win, buf)
	if self.paused then
		return
	end

	local history = vim.tbl_filter(function(b)
		return b ~= buf
	end, self.windows[win] or {})

	table.insert(history, buf)

	self.windows[win] = history
end

---@param win integer
---@param buf integer
function M:remove(win, buf)
	self.windows[win] = vim.tbl_filter(function(b)
		return b ~= buf
	end, self.windows[win] or {})
end

---@param win? integer
function M:clear(win)
	if win == nil then
		self.windows = {}
	else
		self.windows[win] = nil
	end
end

---@param win integer
---@param direction integer
function M:navigate(win, direction)
	local history = self.windows[win] or {}

	if #history == 0 then
		return
	end

	local index = require("wurm.utils").tbl_index(vim.api.nvim_win_get_buf(win), history)

	if index == nil then
		return
	end

	local new_index = index + direction
	if new_index < 1 then
		new_index = #history
	elseif new_index > #history then
		new_index = 1
	end

	self.paused = true
	vim.api.nvim_win_set_buf(win, history[new_index])
	self.paused = false
end

---@param win integer
function M:prev(win)
	self:navigate(win, -1)
end

---@param win integer
function M:next(win)
	self:navigate(win, 1)
end

return M
