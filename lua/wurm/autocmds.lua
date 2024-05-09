local M = {}

local function augroup(name)
	return vim.api.nvim_create_augroup("wurm_" .. name, { clear = true })
end

function M.setup()
	---@class wurm.Config
	local opts = require("wurm.config").options

	vim.api.nvim_create_autocmd("BufWinEnter", {
		group = augroup("push_to_history"),
		pattern = { "*" },
		callback = function()
			-- Only execute in files
			if vim.fn.expand("<afile>") == "" or vim.bo.filetype == "" then
				return
			end

			local win = vim.api.nvim_get_current_win()

			require("wurm.history"):push(win, tonumber(vim.fn.expand("<abuf>")) or 0)
		end,
	})

	vim.api.nvim_create_autocmd("BufWipeout", {
		group = augroup("remove_from_history"),
		pattern = { "*" },
		callback = function()
			-- Only execute in files
			if vim.fn.expand("<afile>") == "" or vim.bo.filetype == "" then
				return
			end

			local win = vim.api.nvim_get_current_win()

			require("wurm.history"):remove(win, tonumber(vim.fn.expand("<abuf>")) or 0)
		end,
	})
end

return M
