return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
    },
    layout = {
      spacing = 3,
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register group names
    wk.add({
      { "<leader>d", group = "Diagnostics/Debug" },
      { "<leader>f", group = "Telescope" },
      { "<leader>h", group = "Git Hunks" },
      { "<leader>l", group = "LSP" },
      { "<leader>m", group = "Format/Diff" },
      { "<leader>p", group = "Picker (Snacks)" },
      { "<leader>s", group = "Splits" },
      { "<leader>t", group = "Toggles" },
      { "<leader>w", group = "Workspace/Session" },
    })
  end,
}
