require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.api.nvim_exec([[
    autocmd FileType go setlocal tabstop=4 shiftwidth=4 expandtab
]], false)

-- Функция для добавления новой строки в конце файла
local function add_newline_at_eof()
  local lastline = vim.fn.getline('$')
  if lastline ~= '' then
    vim.cmd('normal! Go')
  end
end

-- Автокоманда для вызова функции перед сохранением файла
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = add_newline_at_eof,
-- })
