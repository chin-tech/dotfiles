return {
  {
    'nvim-java/nvim-java',
    jdtls = function()
      require('java').setup {}
      require('lspconfig').jdtls.setup {}
    end,
  },
}
