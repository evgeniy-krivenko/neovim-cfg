return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
	},
	config = function()
		-- TODO: setup dap
		local dap = require("dap")
		local ui = require("dapui")

		ui.setup()


		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end

		-- Eval var under cursor
		-- vim.keymap.set("n", "<space>?", function()require("dapui").eval(nil, { enter = true })end)

		require("dap-go").setup()

		dap.adapters.go = {
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}

    dap.adapters.codelldb = {
      type = "executable",
      command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
    }


	end,
	-- keys = {
	-- 	{"<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "[d]ebug [B]reakpoint",},
	-- 	{"<leader>dC", function() require("dap").run_to_cursor() end, desc = "[d]ebug [C]ursor",},
	-- 	{"<leader>dg", function() require("dap").goto_() end, desc = "[d]ebug [g]o to line",},
	-- 	{"<leader>do", function() require("dap").step_over() end, desc = "[d]ebug step [o]ver",},
	-- 	{"<leader>dO", function() require("dap").step_out() end, desc = "[d]ebug step [O]ut",},
	-- 	{"<leader>di", function() require("dap").step_into() end, desc = "[d]ebug [i]nto",},
	-- 	{"<leader>dj", function() require("dap").down() end, desc = "[d]ebug [j]ump down",},
	-- 	{"<leader>dk", function() require("dap").up() end, desc = "[d]ebug [k]ump up",},
	-- 	{"<leader>dl", function() require("dap").run_last() end, desc = "[d]ebug [l]ast",},
	-- 	{"<leader>dp", function() require("dap").pause() end, desc = "[d]ebug [p]ause",},
	-- 	{"<leader>dr", function() require("dap").repl.toggle() end, desc = "[d]ebug [r]epl",},
	-- 	{"<leader>dR", function() require("dap").clear_breakpoints() end, desc = "[d]ebug [R]emove breakpoints",},
	-- 	{"<leader>ds", function() require("dap").session() end, desc = "[d]ebug [s]ession",},
	-- 	{"<leader>dt", function() require("dap").terminate() end, desc = "[d]ebug [t]erminate",},
	-- 	{"<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "[d]ebug [w]idgets",},
	-- },
}
