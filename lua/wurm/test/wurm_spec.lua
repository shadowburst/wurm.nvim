describe("wurm", function()
	before_each(function()
		require("wurm").setup()
		require("wurm.history"):clear()
	end)

	it("can be required", function()
		require("wurm")
	end)

	it("can push to history", function()
		local history = require("wurm.history")

		local win = 0

		history:push(win, "foo")
		assert.are.same({ "foo" }, history.files[win])

		history:push(win, "bar")
		assert.are.same({ "foo", "bar" }, history.files[win])
	end)

	it("can remove from history", function()
		local history = require("wurm.history")

		local win = 0

		history:push(win, "foo")
		history:push(win, "bar")
		history:remove(win, "bar")

		assert.are.same({ "foo" }, history.files[win])
	end)

	it("can navigate history", function()
		local history = require("wurm.history")

		local win = vim.api.nvim_get_current_win()
		local files = {}
		for i = 1, 10, 1 do
			files[i] = "file-" .. i
			history:push(win, files[i])
		end

		vim.cmd("edit " .. files[10])
		assert.are.same(files[10], vim.fn.expand("%:."))

		history:navigate(win, 0)
		assert.are.same(files[10], vim.fn.expand("%:."))

		history:prev(win)
		assert.are.same(files[9], vim.fn.expand("%:."))

		history:next(win)
		assert.are.same(files[10], vim.fn.expand("%:."))

		history:next(win)
		assert.are.same(files[1], vim.fn.expand("%:."))

		history:prev(win)
		assert.are.same(files[10], vim.fn.expand("%:."))
	end)
end)
