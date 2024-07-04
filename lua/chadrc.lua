-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "melange",
  transparency = true,

  hl_override = {
    -- Comment = { italic = true },
    -- ["Function"] = { italic = true },
    -- ["@function"] = { italic = true },
    -- ["@function.builtin"] = { italic = true },
    -- ["@lsp.type.function"] = { italic = true },
    -- ["@type"] = { italic = true },
    ["@keyword"] = { italic = true, fg = "#3a86ff" },
    ["@keyword.conditional"] = { italic = true, fg = "#3a86ff" },
    ["@keyword.return"] = { italic = true, fg = "#3a86ff" },
    -- ["@keyword.function"] = { fg = "#6F8695", italic = true },
    ["@keyword.function"] = { fg = "#3a86ff", italic = true },
    ["@variable.member"] = { italic = true },
    ["@function.method.call"] = { fg = "#BF9573" },
    -- ["@interface"] = { italic = true },
  },
}

return M
