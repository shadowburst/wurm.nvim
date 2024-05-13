---@class wurm
---@field config wurm.Config
---@field histories {[integer]: wurm.History}
local M = {}

---@param opts wurm.PartialConfig?
function M.setup(opts)
	M.config = require("wurm.config").create_config(opts)
	M.histories = {}
	require("wurm.autocmd").setup()
	require("wurm.cmd").setup()
end

---@param win integer?
---@return wurm.History
function M:history(win)
	win = win or vim.api.nvim_get_current_win()

	self.histories[win] = self.histories[win] or require("wurm.history").new()

	return self.histories[win]
end

---@param win integer?
function M:clear(win)
	win = win or vim.api.nvim_get_current_win()

	self.histories[win] = nil
end

return M
