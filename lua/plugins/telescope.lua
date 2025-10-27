return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = true,
      },
      { "nvim-telescope/telescope-file-browser.nvim", enabled = true },
      { "gbrlsnchs/telescope-lsp-handlers.nvim", enabled = true },
    },
    branch = "0.1.x",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.load_extension("lsp_handlers")
      telescope.load_extension("ui-select")

      telescope.setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          path_display = { "smart" },
          layout_config = { prompt_position = "top" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            },
            n = {
              ["x"] = actions.delete_buffer,
              ["q"] = actions.close,
            }
          },
        },
        extensions = {
          file_browser = {
            path = "%:p:h", -- open from within the folder of your current buffer
            display_stat = false, -- don't show file stat
            no_ignore = true,
            grouped = true, -- group initial sorting by directories and then files
            hidden = true, -- show hidden files
            hide_parent_dir = true, -- hide `../` in the file browser
            hijack_netrw = true, -- use telescope file browser when opening directory paths
            prompt_path = true, -- show the current relative path from cwd as the prompt prefix
            use_fd = true, -- use `fd` instead of plenary, make sure to install `fd`
          },
          lsp_handlers = {
            code_action = {
              telescope = require("telescope.themes").get_dropdown({}),
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        pickers = {
          buffers = {
            path_display = { "absolute" }
          }
        }
      })

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
    end,
  },
}
