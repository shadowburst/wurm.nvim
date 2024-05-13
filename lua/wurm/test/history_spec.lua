describe("wurm", function()
	before_each(function()
		require("wurm").setup()
		require("wurm"):history():clear()
	end)

	it("can be required", function()
		require("wurm")
	end)

	it("can append to history", function()
		local history = require("wurm"):history()

		history:append("foo")
		assert.are.same({ "foo" }, history.files)

		history:append("bar")
		assert.are.same({ "foo", "bar" }, history.files)
	end)

	it("can clear history", function()
		local history = require("wurm"):history()

		history:append("foo")
		history:append("bar")
		history:clear()
		assert.are.same({}, history.files)
	end)

	it("can remove from history", function()
		local history = require("wurm"):history()

		history:append("foo")
		history:append("bar")
		history:remove("bar")

		assert.are.same({ "foo" }, history.files)
	end)

	it("can navigate history", function()
		local history = require("wurm"):history()

		local files = {}
		for i = 1, 5, 1 do
			files[i] = "file-" .. i
			history:append(files[i])
		end

		vim.cmd("edit " .. files[1])
		assert.are.same(files[1], vim.fn.expand("%:."))

		history:navigate(0)
		assert.are.same(files[1], vim.fn.expand("%:."))

		history:next()
		assert.are.same(files[2], vim.fn.expand("%:."))

		history:prev()
		assert.are.same(files[1], vim.fn.expand("%:."))
	end)

	it("can wrap history", function()
		local history = require("wurm"):history()

		local files = {}
		for i = 1, 5, 1 do
			files[i] = "file-" .. i
			history:append(files[i])
		end

		vim.cmd("edit " .. files[#files])

		history:next()
		assert.are.same(files[1], vim.fn.expand("%:."))

		history:prev()
		assert.are.same(files[#files], vim.fn.expand("%:."))

		history:next(2)
		assert.are.same(files[2], vim.fn.expand("%:."))

		history:prev(3)
		assert.are.same(files[#files - 1], vim.fn.expand("%:."))
	end)
end)
