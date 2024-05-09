local M = {}

---@generic T
---@param item T
---@param t table<any, T>
---@return number?
function M.tbl_index(item, t)
	for index, value in ipairs(t) do
		if item == value then
			return index
		end
	end
end

return M
