return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          go = {
            "gofumpt",
            "goimports-reviser",
          },
          javascript = { "biome-check" },
          typescript = { "biome-check" },
          javascriptreact = { "biome-check" },
          typescriptreact = { "biome-check" },
          css = { "biome-check" },
          html = { "biome-check" },
          svelte = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          lua = { "stylua" },
          markdown = { "prettier", "markdown-toc" },
        },
        -- format_on_save = {
        -- 	timeout_ms = 500,
        -- 	lsp_fallback = true,
        -- },
        formatters = {
          goimports_reviser = {
            args = {
              "-rm-unused",
            },
          },
        },

        log_level = vim.log.levels.DEBUG,
        eof_newline = true,
      })
    end,
  },
}
