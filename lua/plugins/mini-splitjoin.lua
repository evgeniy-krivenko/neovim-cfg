return {
  {
    "echasnovski/mini.splitjoin",
    config = function()
      local mini_splitjoin = require("mini.splitjoin")
      mini_splitjoin.setup({
        mappings = { toggle = "" },
      })
    end,
  },
}
