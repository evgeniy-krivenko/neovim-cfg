return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "AndrewRadev/splitjoin.vim",
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        -- "prettier",
        -- "stylua",
        "gopls",
        "golangci-lint-langserver",
        "helm-ls",
        "yaml-language-server",
        "json-lsp",
        "templ",
        -- "sqls",
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    lazy = false,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npx --yes yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  -- syntax highlithing
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "go",
        "sql",
        "yaml",
        "json",
        "mermaid",
        "templ",
        "tmux",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    -- for pretty edit
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },
  { "nvim-neotest/nvim-nio" },
  { "nvim-lua/plenary.nvim" },
  { "antoinemadec/FixCursorHold.nvim" },
  { "fredrikaverpil/neotest-golang" },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      {
        "fredrikaverpil/neotest-golang",
        dependencies = {
          {
            "leoluz/nvim-dap-go",
            opts = {},
          },
        },
        branch = "main",
      },
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-golang"] = {
        go_test_args = {
          "-v",
          "-race",
          "-count=1",
          "-timeout=60s",
          -- "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
        },
        dap_go_enabled = true,
        testify_enabled = true,
      }
    end,
    config = function(_, opts)
      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
    keys = {
      { "<leader>ta", function() require("neotest").run.attach() end,                                     desc = "[t]est [a]ttach" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "[t]est run [f]ile" },
      { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "[t]est [A]ll files" },
      { "<leader>tS", function() require("neotest").run.run({ suite = true }) end,                        desc = "[t]est [S]uite" },
      { "<leader>tn", function() require("neotest").run.run() end,                                        desc = "[t]est [n]earest" },
      { "<leader>tl", function() require("neotest").run.run_last() end,                                   desc = "[t]est [l]ast" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "[t]est [s]ummary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[t]est [o]utput" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "[t]est [O]utput panel" },
      { "<leader>tt", function() require("neotest").run.stop() end,                                       desc = "[t]est [t]erminate" },
      { "<leader>td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end,     desc = "Debug nearest test" },
    },
  },
  -- DAP setup
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
        opts = {},
        config = function(_, opts)
          -- setup dap config by VsCode launch.json file
          -- require("dap.ext.vscode").load_launchjs()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "[d]ap [u]i" },
          { "<leader>de", function() require("dapui").eval() end,     desc = "[d]ap [e]val" },
        },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
      },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "toggle [d]ebug [b]reakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "[d]ebug [B]reakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "[d]ebug [c]ontinue (start here)" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "[d]ebug [C]ursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "[d]ebug [g]o to line" },
      { "<leader>do", function() require("dap").step_over() end,                                            desc = "[d]ebug step [o]ver" },
      { "<leader>dO", function() require("dap").step_out() end,                                             desc = "[d]ebug step [O]ut" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "[d]ebug [i]nto" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "[d]ebug [j]ump down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "[d]ebug [k]ump up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "[d]ebug [l]ast" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc = "[d]ebug [p]ause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "[d]ebug [r]epl" },
      { "<leader>dR", function() require("dap").clear_breakpoints() end,                                    desc = "[d]ebug [R]emove breakpoints" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "[d]ebug [s]ession" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "[d]ebug [t]erminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "[d]ebug [w]idgets" },
    },
  },
  {
    "Exafunction/codeium.vim",
    lazy = false,
  },
}
