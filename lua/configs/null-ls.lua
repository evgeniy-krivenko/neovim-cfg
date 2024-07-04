local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- local null_helpers = require("null-ls.helpers")
local null_methods = require "null-ls.methods"

-- Создаем кастомное действие (штуку с null-ls)
local format_eof = {
  name = "add_eof_newline",
  method = null_methods.internal.FORMATTING,
  filetypes = { "go" }, -- Добавьте другие типы файлов, если необходимо
  generator = null_ls.generator {
    fn = function(params)
      local eof_newline = "\n"
      local content = table.concat(params.content, "\n")
      if content:sub(-1) ~= eof_newline then
        content = content .. eof_newline
      end
      return { { text = content, row = 1, col = 1 } }
    end,
    async = true,
  },
}

local opts = {
  sources = {
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines.with {
      extra_args = { "--max-len=130" },
    },
    format_eof,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
return opts
