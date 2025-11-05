return {
  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup({
      compile = true,
      transparent = true,
      dimInactive = true,
      colors = {
        theme = {
          all = {
            ui = {
              float = {
                bg = "none",
                bg_border = "none"
              },
              bg_gutter = "none",
              bg_dim = "none",
              bg_m2 = "none",
              bg_m3 = "none",
              bg = "none",
              bg_search = "none",
              pmenu = {
                bg = "none"
              }
            }
          }
        }
      }
    })

    vim.cmd.colorscheme("kanagawa-wave")
  end
}
