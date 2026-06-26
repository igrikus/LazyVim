return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      terraformls = {
        -- Disable LSP semantic tokens for Terraform.
        -- terraform-ls can emit a semantic token whose length runs past the end
        -- of the buffer. Neovim has a problem with it, so it's better to disable it.
        -- Highlighting still comes from treesitter.
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      },
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
    },
  },
}
