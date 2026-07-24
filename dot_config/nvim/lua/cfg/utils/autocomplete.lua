-- Autocompletion
return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
    },

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-y>'] = { 'select_and_accept' },

        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        ghost_text = {
          enabled = false,
        },
      },

      signature = { enabled = true },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },
      snippets = { preset = 'luasnip' },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
          codecompanion = { 'codecompanion' },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}

--   'hrsh7th/nvim-cmp',
--   event = 'InsertEnter',
-- dependencies = {
--   -- Snippet Engine & its associated nvim-cmp source
--   {
--     'L3MON4D3/LuaSnip',
--     build = (function()
--       -- Build Step is needed for regex support in snippets.
--       -- This step is not supported in many windows environments.
--       -- Remove the below condition to re-enable on windows.
--       if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
--         return
--       end
--       return 'make install_jsregexp'
--     end)(),
--     dependencies = {
--       -- `friendly-snippets` contains a variety of premade snippets.
--       --    See the README about individual language/framework/plugin snippets:
--       --    https://github.com/rafamadriz/friendly-snippets
--       -- {
--       'rafamadriz/friendly-snippets',
--       --   config = function()
--       --     require('luasnip.loaders.from_vscode').lazy_load()
--       --   end,
--       -- },
--     },
--   },
--     'saadparwaiz1/cmp_luasnip',
--     'hrsh7th/cmp-nvim-lsp', -- NOTE: Adds extra completion capabilities;
--                             --  nvim-cmp does not ship with all sources by default. They are split
--                             --  into multiple repos for maintenance purposes.
--     'hrsh7th/cmp-path',
--   },
--   config = function()
--
--     local cmp = require 'cmp'  -- NOTE:  See `:help cmp`
--     local luasnip = require 'luasnip'
--     luasnip.config.setup {}
--
--     cmp.setup {
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       completion = { completeopt = 'menu,menuone,noinsert' },
--       -- NOTE: help: ins-completion for these mappings
--       mapping = cmp.mapping.preset.insert {
--         ['<C-n>'] = cmp.mapping.select_next_item(),
--         ['<C-p>'] = cmp.mapping.select_prev_item(),
--
--         ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- NOTE: Scroll docs back
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- NOTE: SCroll docs forward
--         ['<C-y>'] = cmp.mapping.confirm { select = true }, -- NOTE: Accept LSP completion
--         ['<C-Space>'] = cmp.mapping.complete {}, -- NOTE: Manually trigger completion from nvim-cmp
--
--         -- NOTE: Below bindings allow you jump left/right from the snippet expansion /arguments
--         -- Advanced keymaps can be found: https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
--         ['<C-l>'] = cmp.mapping(function()
--           if luasnip.expand_or_locally_jumpable() then
--             luasnip.expand_or_jump()
--           end
--         end, { 'i', 's' }),
--         ['<C-h>'] = cmp.mapping(function()
--           if luasnip.locally_jumpable(-1) then
--             luasnip.jump(-1)
--           end
--         end, { 'i', 's' }),
--       },
--       sources = {
--         {
--           name = 'lazydev',
--           -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
--           group_index = 0,
--         },
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' },
--         { name = 'path' },
--       },
--     }
--   end,
-- },
-- }
