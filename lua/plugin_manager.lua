-- local plugins = require('plugins')

local M = {
  -- require 'plugins.blink', -- NOTE: replaced by cmp
  require 'plugins.cmp',
  require 'plugins.conform',
  -- require 'plugins.copilot', -- NOTE: wip
  require 'plugins.gitsigns',
  require 'plugins.indent_line',
  require 'plugins.lazydev',
  -- require 'plugins.markdown_preview', -- NOTE: wip
  require 'plugins.mini',
  require 'plugins.neo_tree',
  -- require 'plugins.nvim_autopairs', -- TODO: just use mini?
  -- require 'plugins.nvim_dbee', -- NOTE: wip
  require 'plugins.nvim_lint',
  require 'plugins.nvim_lspconfig',
  require 'plugins.nvim_treesitter',
  require 'plugins.telescope',
  require 'plugins.todo_comments',
  require 'plugins.which_key',
}

require('lazy').setup {
  spec = M,
  change_detection = {
    enabled = true,
    notify = true, --false,
  },
  defaults = {
    lazy = false,
  },
  install = {
    missing = true,
  },
  pkg = {
    -- I don't use plugins that need complex build system, especially
    -- luarocks. The recent updates of lazy.nvim will build luarocks
    -- automatically if the plugin has luarocks spec.
    enabled = false,
  },

  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}

-- -- print('loaded')
