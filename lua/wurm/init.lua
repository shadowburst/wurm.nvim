local M = {}

---@param opts wurm.PartialConfig
function M.setup(opts)
	require("wurm.config").setup(opts)
	require("wurm.autocmds").setup()

	vim.api.nvim_create_user_command("WurmPrev", function()
		require("wurm.history"):prev(vim.api.nvim_get_current_win())
	end, {})

	vim.api.nvim_create_user_command("WurmNext", function()
		require("wurm.history"):next(vim.api.nvim_get_current_win())
	end, {})

	vim.api.nvim_create_user_command("WurmClear", function()
		require("wurm.history"):clear(vim.api.nvim_get_current_win())
	end, {})
end

return M
