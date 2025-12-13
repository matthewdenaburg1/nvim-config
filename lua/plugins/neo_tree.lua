-- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/defaults.lua

local render_icon = function(config, node, state)
  local icon = config.default or ' '
  local padding = config.padding or ' '
  local highlight = config.highlight or ''

  if node.type == 'directory' then
    if node:is_expanded() then
      icon = config.folder_open or '-'
    else
      icon = config.folder_closed or '+'
    end
  end

  return {
    text = icon .. padding,
    highlight = highlight,
  }
end

---@module 'neo-tree'
---@type neotree.Config
local config = {
  window = {
    position = 'right',
  },
  sources = {
    'filesystem',
    -- 'buffers',
    'git_status',
    -- 'document_symbols',
  },
  enable_cursor_hijack = true,
  git_status_async_options = {
    batch_size = 1000, -- how many lines of git status results to process at a time
    batch_delay = 10, -- delay in ms between batches. Spreads out the workload to let other processes run.
    max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
  },
  sort_case_insensitive = true, -- used when sorting files and directories in the tree
  source_selector = {
    truncation_character = '…', -- character to use when truncating the tab label

    sources = {
      { source = 'filesystem' },
      { source = 'git_status' },
    },
  },
  hide_root_node = true, -- Hide the root node.
  name = {
    trailing_slash = true,
    highlight_opened_files = true,
    use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
    use_git_status_colors = true,
    highlight = 'NeoTreeFileName',
  },
  default_component_configs = {
    git_status = {
      symbols = {
        -- Change type
        added = ' ', -- NOTE: you can set any of these to an empty string to not show them
        deleted = 'X',
        modified = 'M',
        renamed = 'R',
        -- Status type
        untracked = 'u',
        ignored = 'ign',
        unstaged = '!',
        staged = '+',
        conflict = 'c',
      },
      align = 'right',
    },
    indent = {
      expander_collapsed = '+',
      expander_expanded = '-',
      padding = 1,
    },
    icon = {
      default = ' ',
      use_filtered_colors = false, -- whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
      folder_closed = '+',
      folder_open = '-',
      folder_empty = 'o',
      folder_empty_open = 'o',
      highlight = '',
    },
    name = {
      trailing_slash = true,
      highlight_opened_files = true,
    },
    type = {
      enabled = false,
    },
  },
  find_by_full_path_words = false,
  filesystem = {
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
    -- items won't be marked if they are visible.
    check_gitignore_in_search = true,
    filtered_items = {
      -- visible = true, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = true,
      never_show = {
        '.git',
      },
    },
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
    },
    components = {
      icon = render_icon,
    },
    use_libuv_file_watcher = true,
  },
}

return { -- 'nvim-neo-tree/neo-tree.nvim',
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    -- 'nvim-tree/nvim-web-devicons', -- optional, but recommended
  },
  keys = {
    { -- NeoTree reveal
      '\\',
      ':Neotree reveal<CR>',
      desc = 'NeoTree reveal',
      silent = true,
    },
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = config,
}
