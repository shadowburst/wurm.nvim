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
			local file = vim.fn.expand("<afile>")

			-- Only execute in files
			if file == "" or vim.bo.filetype == "" then
				return
			end

			local win = vim.api.nvim_get_current_win()

			require("wurm.history"):push(win, file)
		end,
	})

	if opts.forget_closed then
		vim.api.nvim_create_autocmd("BufWipeout", {
			group = augroup("remove_from_history"),
			pattern = { "*" },
			callback = function()
				local file = vim.fn.expand("<afile>")

				-- Only execute in files
				if file == "" or vim.bo.filetype == "" then
					return
				end

				local win = vim.api.nvim_get_current_win()

				require("wurm.history"):remove(win, file)
			end,
		})
	end
end

return M
