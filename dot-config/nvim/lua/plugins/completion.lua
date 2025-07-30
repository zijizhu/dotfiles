return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind.nvim',
    "micangl/cmp-vimtex"
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')
    require('cmp_vimtex').setup()

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      snippet = {
        -- REQUIRED
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({ select = true })
              end
            else
              fallback()
            end
          end
        ),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort()
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'vimtex' },
      }, {
        { name = 'buffer' },
        { name = 'path' }
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          preset = 'default',
          maxwidth = 50,
          ellipsis_char = '...',
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
          menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            vimtex = "[VimTex]"
          })
        })
      }
    })
  end
}
