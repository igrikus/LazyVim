vim.env.GOOGLE_SEARCH_ENGINE_ID = vim.fn.expand("$HOME/.gemini/search_engine_id")
vim.env.GOOGLE_SEARCH_API_KEY = vim.fn.expand("$HOME/.gemini/search_api_key")

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    dependencies = {
      "stevearc/dressing.nvim",
      "ibhagwan/fzf-lua",
    },
    opts = {
      hints = { enabled = false },

      ---@alias AvanteProvider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = "gemini",
      auto_suggestions_provider = "gemini",
      providers = {
        gemini = {
          api_key_name = "cmd: cat " .. vim.fn.expand("$HOME/.gemini/key"),
          model = "gemini-2.5-flash-preview-05-20",
        },
      },
      web_search_engine = {
        provider = "google",
      },
      -- File selector configuration
      --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string
      file_selector = {
        provider = "fzf", -- Avoid native provider issues
        provider_opts = {},
        exclude_auto_select = {
          "tfvars",
        },
      },
    },
    build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
  },
  {
    "saghen/blink.cmp",
    lazy = true,
    dependencies = { "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "avante_commands", "avante_mentions", "avante_files" },
        compat = {
          "avante_commands",
          "avante_mentions",
          "avante_files",
        },
        -- LSP score_offset is typically 60
        providers = {
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90,
            opts = {},
          },
          avante_files = {
            name = "avante_files",
            module = "blink.compat.source",
            score_offset = 100,
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000,
            opts = {},
          },
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = function(_, ft)
      vim.list_extend(ft, { "Avante" })
    end,
    opts = function(_, opts)
      opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
      },
    },
  },
}
