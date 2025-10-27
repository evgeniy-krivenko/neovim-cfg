return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				width = 60,
				row = nil,
				col = nil,
				pane_gap = 4,
				autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
				preset = {
					header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
						{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
						{ icon = " ", key = "s", desc = "Restore Session", action = ":AutoSession restore" },
						{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
			explorer = { enabled = true },
			indent = { enabled = true },
			input = {
				enabled = false,
			},
			quickfile = {
				enabled = true,
				exclude = { "latex" },
			},
      picker = {
        enabled = true,
        matcher = {
          frecency = true
        },
        sources = {
          buffers = {
            focus = "list",
            current = false,
          }
        }
      },
      notifier = { enabled = false },
      scope = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
			-- styles = {
			-- 	input = {
			-- 		keys = {
			-- 			n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
			-- 			i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
			-- 		},
			-- 	},
			-- },
		},
	},
}
