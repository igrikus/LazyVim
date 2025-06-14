return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              useLibraryCodeForTypes = false,
            },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            format = {
              enable = false,
            },
          },
        },
      },
      harper_ls = {
        settings = {
          ["harper-ls"] = {
            codeActions = {
              forceStable = true,
            },
          },
        },
      },
    },
  },
}
