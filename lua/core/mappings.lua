local map = vim.keymap.set
local opts = { silent = true }

local function opt(desc, others)
  return vim.tbl_extend("force", opts, { desc = desc }, others or {})
end

-- new in config
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move line down in v mode" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move line up in v mode" })

map("n", "<C-d>", "<C-d>zz", opt("Scroll down and center"))
map("n", "<C-u>", "<C-u>zz", opt("Scroll up and center"))
map("n", "n", "nzzzv", opt("Next search result and center"))
map("n", "N", "Nzzzv", opt("Previous search result and center"))
map("n", "J", "mzJ`z", opt("Join lines"))
map("v", "<", "<gv", opt("Indent left and reselect"))
map("v", ">", ">gv", opt("Indent right and reselect"))

map("x", "<leader>p", [["_dP]], opt("Paste without yanking"))
map("v", "p", '"_dp', opt("Paste without yanking"))
map({ "v", "n" }, "<leader>d", [["_d]], opt("Delete without yanking"))
map("i", "<C-c>", "<Esc>", opt("Exit insert mode"))
map("n", "<C-c>", ":hohl<CR>", opt("Clear Highlight"))

map("n", "Q", "<nop>", opt("Disable Q"))
map("n", "<C-k>", "<nop>", opt("Disable C-k"))
map("n", "x", '"_x', opt("Delete char without yanking"))

-- Leader
vim.g.mapleader = " "

-- Insert
map("i", "jk", "<ESC>", opts)

-- Buffers
map("n", "<leader>w", ":w<CR>", opt("Save buffer"))

map("n", "<leader>hn", "<Cmd>Gitsigns next_hunk<CR>", opt("Next git hunk"))
map("n", "<leader>hp", "<Cmd>Gitsigns prev_hunk<CR>", opt("Previous git hunk"))
map("n", "<leader>hr", "<Cmd>Gitsigns reset_hunk<CR>", opt("Reset git hunk"))

-- vim.keymap.del("n", "<C-k>")
-- signature_help
-- map('n', '<leader>k', vim.lsp.buf.signature_help, { desc = 'Signature Help' })

-- Navigation
map("n", "<c-k>", ":wincmd k<CR>", opt("Move to window above"))
map("n", "<c-j>", ":wincmd j<CR>", opt("Move to window below"))
map("n", "<c-h>", ":wincmd h<CR>", opt("Move to left window"))
map("n", "<c-l>", ":wincmd l<CR>", opt("Move to right window"))

-- Splits
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally " })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

map("n", "<ESC>", ":noh<CR>", opt("Clear search highlight"))

-- Close
map("n", "<leader>q", ":q<CR>", opt("Quit window"))
map("n", "<leader>Q", ":q!<CR>", opt("Force quit window"))

-- LSP
for _, bind in ipairs({ "grn", "gra", "gri", "grr", "grt" }) do
  pcall(vim.keymap.del, "n", bind)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local picker = require("snacks").picker
    local lsp = vim.lsp
    local opts = { silent = true }


    map("n", "gd", function() require("snacks").picker.lsp_definitions() end, opt("Go to definition"))

    map("n", "gi", picker.lsp_implementations, opt("Go to implementation"))
    map("n", "gr", picker.lsp_references, opt("Show References"))
    map("n", "gl", picker.diagnostics_buffer, opt("Open diagnostic in float"))
    map("n", "<C-k>", lsp.buf.signature_help, opts)

    pcall(vim.keymap.del, "n", "K", { buffer = ev.buf })

    map("n", "K", function() lsp.buf.hover({ border = "single", max_height = 30, max_width = 120 }) end,
      opt("Toggle hover"))
    map("n", "<Leader>lF", vim.cmd.FormatToggle, opt("Toggle AutoFormat"))
    map("n", "<Leader>lI", vim.cmd.Mason, opt("Mason"))
    map("n", "<Leader>lS", lsp.buf.workspace_symbol, opt("Workspace Symbols"))
    map("n", "<Leader>la", lsp.buf.code_action, opt("Code Action"))
    map("n", "<Leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end,
      opt("Toggle Inlayhints"))
    map("n", "<Leader>li", vim.cmd.LspInfo, opt("LspInfo"))
    map("n", "<Leader>ll", lsp.codelens.run, opt("Run CodeLens"))
    map("n", "<Leader>lr", lsp.buf.rename, opt("Rename"))
    map("n", "<Leader>ls", lsp.buf.document_symbol, opt("Doument Symbols"))

    -- diagnostic mappings
    map("n", "<Leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
    map("n", "<Leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end, opt("Prev Diagnostic"))
    map("n", "<Leader>dq", vim.diagnostic.setloclist, opt("Set LocList"))
    map("n", "<Leader>dv", function()
      local config = vim.diagnostic.config()
      config.virtual_lines = not config.virtual_lines
      vim.diagnostic.config(config)
    end, opt("Toggle diagnostic virtual_lines"))
  end,
})

-- Autosession
map("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore Session" })
map("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save Session" })

-- Code actions
map({ "n", "x" }, "<leader>ca", function() require("tiny-code-action").code_action() end, { desc = "Run code action" })

-- Format
map({ "n", "v" }, "<leader>mp", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format whole file or range (in visual mode) with" })

-- Dap
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "debug [c]continue" })
map("n", "<leader>dt", function() require("dap").toggle_breakpoint() end, { desc = "debug [t]oggle beakpoint" })
map("n", "<leader>do", function() require("dap").step_over() end, { desc = "debug step [o]ver" })
map("n", "<leader>dO", function() require("dap").step_out() end, { desc = "debug step [O]ut" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "debug step [i]nto" })
map("n", "<leader>dj", function() require("dap").down() end, { desc = "debug step [j]ump down" })
map("n", "<leader>dk", function() require("dap").up() end, { desc = "debug step [k]ump up" })
map("n", "<leader>dT", function() require("dap").terminate() end, { desc = "debug [T]erminate" })

-- Diffview
map("n", "<leader>mo", ":DiffviewOpen<CR>", { desc = "Open git diff" })
map("n", "<leader>mc", ":DiffviewClose<CR>", { desc = "Open git diff" })


-- Gitsigns
map('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    require('gitsigns').nav_hunk('next')
  end
end, opt("Next git change/hunk"))

map('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal({ '[c', bang = true })
  else
    require('gitsigns').nav_hunk('prev')
  end
end, opt("Previous git change/hunk"))

-- Gitsigns actions
map('n', '<leader>hs', function() require('gitsigns').stage_hunk() end, opt("Stage hunk"))
map('n', '<leader>hr', function() require('gitsigns').reset_hunk() end, opt("Reset hunk"))
map('v', '<leader>hs', function()
  require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, opt("Stage hunk (visual)"))
map('v', '<leader>hr', function()
  require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, opt("Reset hunk (visual)"))
map('n', '<leader>hS', function() require('gitsigns').stage_buffer() end, opt("Stage buffer"))
map('n', '<leader>hR', function() require('gitsigns').reset_buffer() end, opt("Reset buffer"))
map('n', '<leader>hp', function() require('gitsigns').preview_hunk() end, opt("Preview hunk"))
map('n', '<leader>hi', function() require('gitsigns').preview_hunk_inline() end, opt("Preview hunk inline"))
map('n', '<leader>hb', function() require('gitsigns').blame_line({ full = true }) end, opt("Blame line"))
map('n', '<leader>hd', function() require('gitsigns').diffthis() end, opt("Diff this"))
map('n', '<leader>hD', function() require('gitsigns').diffthis('~') end, opt("Diff this (cached)"))
map('n', '<leader>hQ', function() require('gitsigns').setqflist('all') end, opt("All hunks to quickfix"))
map('n', '<leader>hq', function() require('gitsigns').setqflist() end, opt("Hunks to quickfix"))
-- Toggles
map('n', '<leader>tb', function() require('gitsigns').toggle_current_line_blame() end, opt("Toggle line blame"))
map('n', '<leader>tw', function() require('gitsigns').toggle_word_diff() end, opt("Toggle word diff"))
-- Text object
map({ 'o', 'x' }, 'ih', function() require('gitsigns').select_hunk() end, opt("Select hunk"))

-- Golang keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<C-i>", ":GoImports<CR>", opt("Go: Organize imports"))
    vim.api.nvim_buf_set_keymap(0, "n", "<C-b>", ":GoBuild %:h<CR>", opt("Go: Build package"))
    vim.api.nvim_buf_set_keymap(0, "n", "<C-g>", ":GoGenerate<CR>", opt("Go: Generate"))
    vim.api.nvim_buf_set_keymap(0, "n", "<C-t>", ":GoTestPkg<CR>", opt("Go: Test package"))
    vim.api.nvim_buf_set_keymap(0, "n", "<leader-ra>", ":GoRename<CR>", opt("Go: Rename"))
  end,
  group = vim.api.nvim_create_augroup("GoMappings", { clear = true }),
})

-- Split join
map({ "n", "x" }, "sj", function() require("mini.splitjoin").join() end, { desc = "Join args" })
map({ "n", "x" }, "sk", function() require("mini.splitjoin").split() end, { desc = "Split args" })

-- Folding
-- za to fold at cursor location is already enabled
map("n", "zR", function() require("ufo").openAllFolds() end, opt("Open all folds"))
map("n", "zM", function() require("ufo").closeAllFolds() end, opt("Close all folds"))

-- Snacks git
map("n", "<leader>lg", function() require("snacks").lazygit() end, { desc = "Lazygit" })
-- {"<leader>gl", function() require("snacks").lazygit.log() end, desc = "Lazygit logs",},
map("n", "<leader>rN", function() require("snacks").rename.rename_file() end, { desc = "Fast Rename File" })
-- { "<leader>dB", function() require("snacks").bufdelete() end,          desc = "Delete or Close Buffer" },
-- Snacks Picker
local buffers_cfg = { layout = "vertical", focus = "list", current = false, matcher = { history_bonus = true }  }

map("n", "<leader>pf", function() require("snacks").picker.files() end, { desc = "Find Files (Snacks Picker)" })
map("n", "=", function() require("snacks").picker.buffers(buffers_cfg) end, { desc = "Buffers (Snacks Picker)" })
-- {"<leader>pc", function() require("snacks").picker.files({ cwd = "~/dotfiles/nvim/.config/nvim/lua" }) end, desc = "Find Config File",},
map("n", "<leader>pw", function() require("snacks").picker.grep() end, { desc = "Grep word" })
map({"n", "x" }, "<leader>pws", function() require("snacks").picker.grep_word() end, { desc = "Search Visual selection or Word", })
-- {"<leader>pk", function() require("snacks").picker.keymaps({ layout = "ivy" }) end, desc = "Search Keymaps (Snacks Picker)",},
map("n", "<leader>e", function() require("snacks").picker.explorer({ auto_close = true }) end, { desc = "Snacks Explorer" })

-- Telescope (Deprecated)
-- map("n", "-", ":Telescope file_browser<CR>", opt("Telescope file browser"))
-- map("n", "=", "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=dropdown<cr>")
map("n", "<leader>fr", function() require("telescope.builtin").find_files() end, opt("Find files")) -- Lists files in your current working directory, respects .gitignore
map("n", "<leader>fx", function() require("telescope.builtin").treesitter() end, opt("Treesitter symbols")) -- Lists tree-sitter symbols
map("n", "<leader>fs", function() require("telescope.builtin").spell_suggest() end, opt("Spell suggestions")) -- Lists spell options
map("n", "<leader>fo", function() require("telescope.builtin").oldfiles() end, opt("Recent files")) -- Lists spell options
map("n", "<leader>fw", function() require("telescope.builtin").live_grep() end, opt("Live grep"))

-- Undotree
map("n", "<leader>u", vim.cmd.UndotreeToggle, opt("Toggle Undotree"))
