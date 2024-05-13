---@type wurm.Config
local Config = require("wurm").config
local Utils = require("wurm.utils")

---@class wurm.History
---@field files string[]
---@field paused boolean
local M = {
	files = {},
	paused = false,
}

---@return wurm.History
function M.new()
	return setmetatable({
		files = {},
		paused = false,
	}, { __index = M })
end

---@param file string filepath relative to the cwd
function M:append(file)
	if self.paused then
		return
	end

	self.files = vim.tbl_filter(function(f)
		return f ~= file
	end, self.files or {})

	table.insert(self.files, file)

	if #self.files > Config.max_history then
		table.remove(self.files, 1)
	end
end

---@param file string filepath relative to the cwd
function M:remove(file)
	self.files = vim.tbl_filter(function(f)
		return f ~= file
	end, self.files or {})
end

function M:clear()
	self.files = {}
end

---@param offset integer
function M:navigate(offset)
	if #self.files == 0 then
		return
	end

	local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")

	local index = Utils.tbl_index(file, self.files)

	if index == nil then
		return
	end

	local new_index = index + offset
	if new_index < 1 then
		new_index = #self.files + new_index -- wrap to the end of list, accounting for the offset
	elseif new_index > #self.files then
		new_index = new_index - #self.files -- wrap to the start of list, accounting for the offset
	end

	self.paused = true
	vim.cmd("edit " .. self.files[new_index])
	self.paused = false
end

---@param offset integer?
function M:prev(offset)
	self:navigate(-(math.max(offset or 1, 1)))
end

---@param offset integer?
function M:next(offset)
	self:navigate(math.max(offset or 1, 1))
end

return M
