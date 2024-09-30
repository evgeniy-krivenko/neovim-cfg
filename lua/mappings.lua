require "nvchad.mappings"

local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("n", "<leader>w", "<cmd>w<CR>")
map("n", "\\", "<cmd>:vsplit <CR>", { desc = "vertical split" })
map("n", "<leader>/", "gcc", { remap = true })
map("i", "<C-j>", "<C-n>", { remap = true })
map("i", "<C-k>", "<C-p>", { remap = true })

map("n", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.4 }
end, { desc = "Vertical toggle terminal" })
map("t", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp" }
end)

map({ "n", "t" }, "<C-\\>", function()
  require("nvchad.term").toggle { pos = "sp", }
end, { desc = "Horizontal toggle termanil" })

map("n", "]c", function()
  require("gitsigns").nav_hunk('next')
end, { desc = "Next git hunk" })

-- tests
map("n", "<leader>tt", function()
  -- run_go_test()
  require("neotest").run.run()
end, { desc = "Run neotest tests" })
