-- Line Numbers
vim.wo.number = true
vim.wo.relativenumber = true


-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Clipboard
vim.opt.clipboard:append("unnamedplus")
vim.opt.hlsearch = true

vim.opt.vb = true
vim.opt.ruler = true
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.autoindent = true
vim.opt.backup = false
vim.opt.undofile = true

-- don't now
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.colorcolumn = "120"
-- vim.opt.textwidth = 120
--
vim.opt.signcolumn = "yes"

vim.opt.backspace = { "start", "eol", "indent" }

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.updatetime = 50

-- Indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- vim.opt.autoindent = true
vim.opt.smartindent = true

vim.api.nvim_exec([[
    autocmd FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=2 expandtab
]], false)

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- Other
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.fillchars = {
  vert = "│",
  fold = "⠀",
  eob = " ", -- suppress ~ at EndOfBuffer
  -- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸"
}

-- Rust disable inlay_hints
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust" },
  callback = function(ev)
    vim.lsp.inlay_hint.enable(false)
  end,
  group = vim.api.nvim_create_augroup("rust_autocommands", { clear = true }),
})


--  vim.cmd(string.format([[highlight WinBar1 guifg=%s]], "#ff9999"))
--   -- -- Set the winbar to display "skitty-notes" with the specified color
--   -- vim.opt.winbar = "%#WinBar1#   skitty-notes%*"
--   -- -- Set the winbar to display the current file name on the left and "linkarzu.com" aligned to the right
--   -- vim.opt.winbar = "%#WinBar1# %t%*%=%#WinBar1# linkarzu.com %*"
--   -- Set the winbar to display the current file name on the left (without the extension) and "linkarzu.com" aligned to the right
--   vim.opt.winbar =
--     '%#WinBar1# %{luaeval(\'vim.fn.fnamemodify(vim.fn.expand("%:t"), ":r")\')}%*%=%#WinBar1# linkarzu.com %*'
--
--
-- -- Функция для получения количества открытых буферов
-- local function get_buffer_count()
--   local count = 0
--   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--     if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
--       count = count + 1
--     end
--   end
--   return count
-- end
--
-- -- Функция для получения статуса модификации
-- local function get_modified_status()
--   return vim.bo.modified and "[+]" or ""
-- end
--
-- -- Функция для получения имени файла
-- local function get_filename()
--   local filename = vim.fn.expand('%:t')
--   if filename == '' then
--     return '[No Name]'
--   end
--   return filename
-- end
--
-- vim.opt.statusline = [[%f %m%= Буферы: %{luaeval("vim.tbl_count(vim.tbl_filter(function(b) return vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted end, vim.api.nvim_list_bufs()))")} %l:%c %p%%]]
-- -- Настройка statusline
