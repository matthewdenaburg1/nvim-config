-- Collection of various small independent plugins/modules
-- https://github.com/nvim-mini/mini.nvim

return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    -- Better Around/Inside textobjects
    require('mini.ai').setup { n_lines = 500 }

    require('mini.comment').setup()
    require('mini.move').setup()
    require('mini.pairs').setup()

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require('mini.surround').setup()

    require('mini.trailspace').setup()

    local align = require 'mini.align'
    align.setup {
      options = {
        split_pattern = '%s+',
      },
      steps = {
        pre_split = {
          align.gen_step.ignore_split({ [[".-"]], [['.-']], [[`.-`]] }, true),
        },
      },
    }

    require('mini.colors').setup()
    -- default colorscheme
    vim.cmd.colorscheme 'my_slate'

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }
    --
    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- ... and there is more!
    --  Check out: https://github.com/nvim-mini/mini.nvim
  end,
}
