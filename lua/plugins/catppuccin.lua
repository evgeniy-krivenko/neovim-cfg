return {
  "catppuccin/nvim",
  name = "catppuccin",
  tag = "v1.11.0",
  lazy = false,
  enabled = true,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true

    local catppuccin = require("catppuccin")

    catppuccin.setup({
      flavour = "mocha",
      term_colors = true,
      styles = {
        conditionals = {},
        functions = { "italic" },
        types = { "bold" }
      },
      transparent_background = true,
      show_end_of_buffer = true,
      -- now is false, TODO: later try to turn on
      dim_inactive = {
        enabled = false,   -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      color_overrides = {
        mocha = {
          -- base = "#242526",     -- background
          -- surface2 = "#9A9A9A", -- comments
          -- text = "#F6F6F6"
        }
      },
      highlight_overrides = {
        mocha = function(C)
          return {
            NvimTreeNormal = { bg = C.none },
            TabLine = { bg = C.none },
            CmpBorder = { fg = C.surface2 },
            Pmenu = { bg = C.none },
            NormalFloat = { bg = C.none },
            TelescopeBorder = { link = "FloatBorder" },

            CursorLine = { bg = C.none },
            -- barbar
            BufferCurrent = { bg = C.surface1, fg = C.text },
            BufferCurrentIndex = { bg = C.surface1, fg = C.blue },
            BufferCurrentMod = { bg = C.surface1, fg = C.yellow },
            BufferCurrentSign = { bg = C.surface1, fg = C.blue },
            BufferCurrentTarget = { bg = C.surface1, fg = C.red },
            BufferVisible = { bg = C.mantle, fg = C.text },
            BufferVisibleIndex = { bg = C.mantle, fg = C.blue },
            BufferVisibleMod = { bg = C.mantle, fg = C.yellow },
            BufferVisibleSign = { bg = C.mantle, fg = C.blue },
            BufferVisibleTarget = { bg = C.mantle, fg = C.red },
            BufferInactive = { bg = C.none, fg = C.overlay0 },
            BufferInactiveIndex = { bg = C.none, fg = C.overlay0 },
            BufferInactiveMod = { bg = C.none, fg = C.yellow },
            BufferInactiveSign = { bg = C.none, fg = C.blue },
            BufferInactiveTarget = { bg = C.mantle, fg = C.red },
            BufferTabpages = { bg = C.mantle, fg = C.none },
            BufferTabpage = { bg = C.mantle, fg = C.surface1 },
            BufferDefaultTabpageFill = { bg = C.none },
          }
        end
      },
      integrations = {
        bufferline = false,
        cmp = true,
        gitsigns = true,
        native_lsp = { enabled = true },
        treesitter = true,
        treesitter_context = true
      }
    })

    vim.cmd.colorscheme("catppuccin")
  end
}
