---@class wurm.Config
local Config = require("wurm.config").options
local Utils = require("wurm.utils")

---@class wurm.History
---@field paused boolean
---@field files table
local M = {
	paused = false,
	files = {},
}

---@param win integer
---@param file string filepath relative to the cwd
function M:push(win, file)
	if self.paused then
		return
	end

	local history = vim.tbl_filter(function(f)
		return f ~= file
	end, self.files[win] or {})

	table.insert(history, file)

	if #history > Config.max_history then
		table.remove(history, 1)
	end

	self.files[win] = history
end

---@param win integer
---@param file string filepath relative to the cwd
function M:remove(win, file)
	self.files[win] = vim.tbl_filter(function(f)
		return f ~= file
	end, self.files[win] or {})
end

---@param win? integer
function M:clear(win)
	if win == nil then
		self.files = {}
	else
		self.files[win] = nil
	end
end

---@param win integer
---@param direction integer
function M:navigate(win, direction)
	local history = self.files[win] or {}

	if #history == 0 then
		return
	end

	local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)), ":.")

	local index = Utils.tbl_index(file, history)

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
	vim.cmd("edit " .. history[new_index])
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
