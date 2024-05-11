local M = {}

---@class wurm.Config
---@field max_history number
---@field forget_closed boolean
local defaults = {
	max_history = 15,
	forget_closed = true,
}

---@class wurm.PartialConfig
---@field max_history number?
---@field forget_closed boolean?

---@param opts wurm.PartialConfig
function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
