local M = {}

---@class wurm.Config
local defaults = {}

---@class wurm.PartialConfig

---@param opts wurm.PartialConfig
function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
