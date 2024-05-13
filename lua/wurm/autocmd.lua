local M = {}

---@type wurm.Config
local Config = require("wurm").config

local function augroup(name)
	return vim.api.nvim_create_augroup("wurm." .. name, { clear = true })
end

function M.setup()
	vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
		group = augroup("history.append"),
		pattern = { "*" },
		callback = function()
			local file = vim.fn.expand("<afile>")

			-- Only execute in valid files
			if file == "" or vim.bo.filetype == "" then
				return
			end

			require("wurm"):history():append(file)
		end,
	})

	vim.api.nvim_create_autocmd({ "WinClosed" }, {
		group = augroup("history.clear"),
		pattern = { "*" },
		callback = function()
			local window = vim.fn.expand("<amatch>")

			-- Only execute in valid files
			if window == "" or vim.bo.filetype == "" then
				return
			end

			require("wurm"):clear(tonumber(window))
		end,
	})

	if Config.forget_closed then
		vim.api.nvim_create_autocmd({ "BufWipeout" }, {
			group = augroup("history.remove"),
			pattern = { "*" },
			callback = function()
				local file = vim.fn.expand("<afile>")

				-- Only execute in valid files
				if file == "" or vim.bo.filetype == "" then
					return
				end

				require("wurm"):history():remove(file)
			end,
		})
	end
end

return M
