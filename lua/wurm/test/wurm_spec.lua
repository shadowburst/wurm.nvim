describe("wurm", function()
	before_each(function()
		require("wurm.history"):clear()
	end)

	it("can be required", function()
		require("wurm")
	end)

	it("can push to history", function()
		local history = require("wurm.history")

		local win = 0

		history:push(win, 0)
		assert.are.same({ 0 }, history.windows[win])

		history:push(win, 1)
		assert.are.same({ 0, 1 }, history.windows[win])
	end)

	it("can remove from history", function()
		local history = require("wurm.history")

		local win = 0

		history:push(win, 0)
		history:push(win, 1)
		history:remove(win, 1)

		assert.are.same({ 0 }, history.windows[win])
	end)

	it("can navigate history", function()
		local history = require("wurm.history")

		local win = vim.api.nvim_get_current_win()
		local buffers = {}
		for i = 1, 10, 1 do
			buffers[i] = vim.api.nvim_create_buf(true, false)
			history:push(win, buffers[i])
		end

		vim.api.nvim_win_set_buf(win, buffers[10])

		history:navigate(win, 0)
		assert.are.same(buffers[10], vim.api.nvim_win_get_buf(win))

		history:prev(win)
		assert.are.same(buffers[9], vim.api.nvim_win_get_buf(win))

		history:next(win)
		assert.are.same(buffers[10], vim.api.nvim_win_get_buf(win))

		history:next(win)
		assert.are.same(buffers[1], vim.api.nvim_win_get_buf(win))
	end)
end)
