local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = {
      "gofumpt",
      "golines",
      "gci",
    },
    sql = { "sql_formatter" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    golines = {
      args = { "--max-len=130" },
    },
    gci = {
      args = { "write", "-s=standard", "-s=default", "-s=prefix(fastronom)", "--skip-generated", "--skip-vendor", "--custom-order", "$FILENAME" }
    }
  },

  log_level = vim.log.levels.DEBUG,
  -- eof_newline = true,
}

require("conform").setup(options)
