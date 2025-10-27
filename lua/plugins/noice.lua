return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = true,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
		debug = true,
		config = function()
			local noice = require("noice")

			noice.setup({
				cmdline = {
					enabled = true,
					view = "cmdline_popup",
				},
				views = {
					popupmenu = {
						relative = "editor",
						position = {
							row = 8,
							col = "50%",
						},
						size = {
							width = 60,
							height = 10,
						},
						win_options = {
							winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
						},
					},
					cmdline_popup = {
						position = {
							row = 5, -- Центр по вертикали (50% от высоты)
							col = "50%", -- Центр по горизонтали
						},
						size = {
							width = 60, -- Ширина в символах
							height = "auto", -- Авто-высота
						},
						border = {
							style = "rounded", -- Стиль бордера (rounded, single и т.д.)
							padding = { 0, 1 }, -- Отступы
						},
					},
					mini = {
						size = {
							width = "auto",
							height = "auto",
							max_height = 15,
						},
						position = {
							row = -2,
							col = "100%",
						},
					},
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							any = {
								{ find = "%d+L, %d+B" },
								{ find = "; after #%d+" },
								{ find = "; before #%d+" },
								{ find = "%d fewer lines" },
								{ find = "%d more lines" },
							},
						},
						opts = { skip = true },
					},
				},
				messages = {
					enabled = false,
				},
				health = {
					checker = true,
				},
				popupmenu = {
					enabled = true,
				},
				signature = {
					enabled = true,
				},
			})
		end,
	},
}
