-- show hex codes as colors
-- https://github.com/norcalli/nvim-colorizer.lua

local webdev_styles = {
  -- SASS specific
  sass = {
    enable = true,
    parsers = { 'css' },
    mode = 'foreground',
  },
}

return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    user_default_options = {
      mode = 'virtualtext',
      virtualtext = '    ',
      virtualtext_mode = 'background',

      names = false,

      filetypes = {
        '*',
        css = webdev_styles,
        scss = webdev_styles,
      },
    },
  },
}
