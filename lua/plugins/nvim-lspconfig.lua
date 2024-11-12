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
    },
  },
}
