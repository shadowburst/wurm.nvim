local M = {}

function M.setup()
	vim.api.nvim_create_user_command("WurmPrev", function(args)
		require("wurm"):history():prev(args.count)
	end, { count = true })

	vim.api.nvim_create_user_command("WurmNext", function(args)
		require("wurm"):history():next(args.count)
	end, { count = true })

	vim.api.nvim_create_user_command("WurmClear", function()
		require("wurm"):history():clear()
	end, {})
end

return M
