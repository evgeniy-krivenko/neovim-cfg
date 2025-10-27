return {
	{
		"nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "master",
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" }, -- Syntax aware text-objects
			{
				"nvim-treesitter/nvim-treesitter-context", -- Show code context
				opts = { enable = true, mode = "topline", line_numbers = true },
			},
		},
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "markdown" },
				callback = function(ev)
					-- treesitter-context is buggy with Markdown files
					require("treesitter-context").disable()
				end,
			})

			treesitter.setup({
				ensure_installed = {
					"csv",
					"dockerfile",
					"gitignore",
					"go",
					"gomod",
					"gosum",
					"gowork",
					"javascript",
					"typescript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"proto",
					"python",
					"rust",
					"sql",
					"svelte",
					"yaml",
					"html",
					"templ",
					"c",
					"tsx",
					"java",
					"gitignore",
				},
				indent = { enable = true },
				auto_install = true,
				sync_install = false,
				highlight = {
					enable = true,
					disable = { "csv" }, -- preferring chrisbra/csv.vim
				},
				textobjects = { select = { enable = true, lookahead = true } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
					},
				},
				additional_vim_regex_highlighting = false,
			})
		end,
	},
	-- NOTE: js,ts,jsx,tsx Auto Close Tags
	{
		"windwp/nvim-ts-autotag",
		enabled = true,
		ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
		config = function()
			-- Independent nvim-ts-autotag setup
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto-close tags
					enable_rename = true, -- Auto-rename pairs
					enable_close_on_slash = false, -- Disable auto-close on trailing `</`
				},
				per_filetype = {
					["html"] = {
						enable_close = true, -- Disable auto-closing for HTML
					},
					["typescriptreact"] = {
						enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
					},
				},
			})
		end,
	},
}
