-- Highlight todo, notes, etc in comments
-- https://github.com/folke/todo-comments.nvim

return {
  'folke/todo-comments.nvim',

  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  event = 'VimEnter',
  config = function()
    -- Default keywords
    -- see https://github.com/folke/todo-comments.nvim/blob/main/lua/todo-comments/config.lua
    local default_keywords = {
      FIX = {
        icon = '',
        color = 'error',
        alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'FAILED' },
      },
      TODO = { icon = '', color = 'info' },
      HACK = { icon = '', color = 'warning', alt = { 'WTF' } },
      WARN = { icon = '', color = 'warning', alt = { 'WARNING', 'XXX' } },
      PERF = { icon = '', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = '', color = 'hint', alt = { 'INFO', 'TIP' } },
      TEST = { icon = '', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    }

    -- custom keywords
    local keywords = {
      SEE = { color = 'info' },
    }

    -- see https://github.com/folke/todo-comments.nvim/issues/177
    keywords = vim.tbl_deep_extend('force', {}, default_keywords, keywords)
    -- Add extra versions of each keyword
    for key, val in pairs(keywords) do
      -- lower case
      keywords[key:lower()] = val
      -- proper case
      keywords[key:sub(1, 1) .. key:sub(2):lower()] = val
      -- ensure upper case version exists
      keywords[key:upper()] = val
    end

    require('todo-comments').setup {
      keywords = keywords,
      gui_style = {
        fg = 'bold', -- The gui style to use for the fg highlight group.
      },
      highlight = {
        keyword = 'bg',
        pattern = [[^\s*(--\s*\@?(KEYWORDS)(\s|:))]], -- vim regex

        multiline = true, -- enable multine todo comments
        multiline_pattern = [[^%s*--%s*.{1}]], -- lua regex
      },
      colors = {
        error = { '#DC2626' },
        warning = { '#FBBF24' },
        info = { '#2593EB' },
        hint = { '#10B981' },
        default = { '#AA66FF' },
        test = { '#FF00FF' },
      },
    }
  end,
}
