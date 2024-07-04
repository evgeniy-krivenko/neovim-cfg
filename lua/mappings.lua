require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>w", "<cmd>w<CR>")
map("n", "\\", "<cmd>:vsplit <CR>", { desc = "vertical split" })
map("n", "<leader>/", "gcc", { remap = true })
map("i", "<C-j>", "<C-n>", { remap = true })
map("i", "<C-k>", "<C-p>", { remap = true })

map({ "n", "t" }, "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vertical", size = 0.3 }
end, { desc = "Vertical toggle terminal" })
map({ "n", "t" }, "<C-\\>", function()
  require("nvchad.term").toggle { pos = "sp", id = "hor" }
end, { desc = "Horizontal toggle termanil" })

map("n", "]c", function()
  require("gitsigns").nav_hunk('next')
end, { desc = "Next git hunk" })

-- tests
map("n", "<leader>tt", function()
  -- run_go_test()
  require("neotest").run.run()
end, { desc = "Run neotest tests" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
