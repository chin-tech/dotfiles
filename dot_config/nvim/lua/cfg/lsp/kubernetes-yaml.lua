return {
  'cwrau/yaml-schema-detect.nvim',
  ---@module "yaml-schema-detect"
  ---@type YamlSchemaDetectOptions
  opts = {}, -- use default options
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  ft = { 'yaml' },
}
