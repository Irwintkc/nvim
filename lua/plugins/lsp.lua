return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          on_attach = function(client, bufnr)
            client.server_capabilities.inlayHintProvider = false
            client.server_capabilities.documentHighlightProvider = false

            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            vim.lsp.buf.clear_references()
          end,
          settings = {
            texlab = {
              inlayHints = {
                labelDefinitions = false,
                labelReferences = false,
              },
            },
          },
        },
      },
    },
  },
}
