-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'sql' },
--   callback = function()
--     vim.treesitter.start()
--   end,
-- })

-- auto trim on save
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    MiniTrailspace.trim()
  end,
})
