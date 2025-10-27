return {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
    -- main picker
		{
			"folke/snacks.nvim",
			opts = {
				terminal = {},
			},
		},
	},
	event = "LspAttach",
	opts = {},
	config = function()
		local code_action = require("tiny-code-action")

		code_action.setup({
			picker = {
				"buffer",
				opts = {
					hotkeys = true, -- Enable hotkeys for quick selection of actions
					hotkeys_mode = "text_diff_based", -- Modes for generating hotkeys
					auto_preview = false, -- Enable or disable automatic preview
					auto_accept = false, -- Automatically accept the selected action
					position = "cursor", -- Position of the picker window
					winborder = "single", -- Border style for picker and preview windows
					custom_keys = {
						{ key = "m", pattern = "Fill match arms" },
						{ key = "r", pattern = "Rename.*" }, -- Lua pattern matching
					},
				},
			},
		})
	end,
}
