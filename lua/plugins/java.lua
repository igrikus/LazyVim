return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {
            settings = {
              java = {
                format = {
                  enabled = true,
                },
              },
            },
          },
        },
        setup = {
          jdtls = function()
            require("java").setup({
              java_test = {
                enable = false,
              },
              java_debug_adapter = {
                enable = false,
              },
              spring_boot_tools = {
                enable = false,
              },
              notifications = {
                dap = false,
              },
            })
          end,
        },
      },
    },
  },
}
