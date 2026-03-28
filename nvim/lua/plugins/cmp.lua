-- Completion
-- https://github.com/hrsh7th/nvim-cmp

-- TODO: see if it's possible to disable line numbers when in command mode

return {
  'hrsh7th/nvim-cmp',

  event = {
    'InsertEnter',
    'CmdlineEnter',
  },
  dependencies = {
    -- Completion sources
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua', -- Lua API completion (optional)
    'hrsh7th/cmp-cmdline', -- for : and / completion

    -- Snippets
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',

    -- (Optional) autopairs integration for function call completion
    'windwp/nvim-autopairs',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    -- Load community snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    -- OPTIONAL: autopairs on confirm
    local ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
    if ok then
      local ap = require 'nvim-autopairs'
      ap.setup {}
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end

    cmp.setup {
      -- Disable completion in comments
      enabled = function()
        local context = require 'cmp.config.context'
        -- Keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
          return true
        else
          return not context.in_treesitter_capture 'comment' and not context.in_syntax_group 'Comment'
        end
      end,

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- UI / formatting (simple defaults)
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      -- mappings
      mapping = cmp.mapping.preset.insert {
        -- Navigate menu
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Scroll docs
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),

        -- Trigger completion
        ['<C-space>'] = cmp.mapping.complete(),

        -- Abort
        ['<Esc>'] = cmp.mapping.abort(),

        -- CONFIRM: choose your key here
        -- Example: use <C-y> to accept (and disable <CR> to keep newline behavior)
        ['<CR>'] = cmp.config.disable,
        ['<C-y>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace, -- or Insert
          select = true, -- confirm first item when none selected
        },

        -- Optional: Tab to confirm when menu open; fallback otherwise
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },

      sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
        -- { name = "nvim_lua" }, -- uncomment if you want Lua API completion
      },
    }

    -- Optional: cmdline completion (":" and "/")
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
      -- Disable completion for specific commands if you like:
      -- matching = { disallow_symbol_nonprefix_matching = false },
    })

    -- LSP capabilities (hook into your LSP config)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Example: if you use lspconfig elsewhere, pass capabilities:
    -- require("lspconfig").tsserver.setup({ capabilities = capabilities })
    -- require("lspconfig").lua_ls.setup({ capabilities = capabilities })
    -- ... etc.
  end,
}
