-- ===================================================
-- Extend build-in keymaps and functionality
-- ===================================================

local keymap = vim.keymap.set

---@alias options_table table<any, any>

---@type options_table
local opts = {
  noremap = true,
  silent = true,
}
local no_silent = {
  noremap = true,
  silent = false,
}

---@param desc string: a description of what the keymap ds
---@param base_opts? options_table
local function opts_desc(desc, base_opts)
  base_opts = base_opts or opts
  return vim.tbl_extend('force', base_opts, {
    desc = desc or '',
  })
end

----------- Buffer movement
-- In Vim, `C-b` and `C-f` scroll by a full page, while `C-u` and `C-d` scroll by half a page.
-- We want to always scroll by a half page.
keymap('n', '<C-f>', '<C-d>', opts_desc 'scroll down a half page')
keymap('n', '<C-b>', '<C-u>', opts_desc 'scroll up a half page')

keymap('n', ']b', [[:bnext<cr>]], opts_desc 'next buffer')
keymap('n', '[b', [[:bprevious<cr>]], opts_desc 'previous buffer')
keymap('n', ']q', [[:cnext<cr>]], opts_desc 'next quicklist entry')
keymap('n', '[q', [[:cprevious<cr>]], opts_desc 'previous quicklist entry')
keymap('n', ']Q', [[:cnewer<cr>]], opts_desc 'newer quicklist')
keymap('n', '[Q', [[:colder<cr>]], opts_desc 'older quicklist')
keymap('n', ']t', [[:tnext<cr>]], opts_desc 'next tag')
keymap('n', '[t', [[:tprevious<cr>]], opts_desc 'previous tag')

-- -- open loclist to show the definition matches at current word
-- -- <C-R> insert text in the register to the command line
-- -- <C-W> alias for the word under cursor
-- keymap('n', 'leader>mt', [[:ltag <C-R><C-W> | lopen<cr>]], opts_desc 'misc: tag word to loclist')

-- keymap('n', 'leader>bd', [[:bd!<CR>]], opts_desc 'buffer delete current one')
-- keymap('n', 'leader>bw', [[:bw!<CR>]], opts_desc 'buffer wipeout current one')
keymap('n', '<leader>bp', [[:bprevious<CR>]], opts_desc 'buffer next')
keymap('n', '<leader>bn', [[:bnext<CR>]], opts_desc 'buffer previous')

----------- Toggle settings
keymap('n', '<leader>tw', '<cmd>lua vim.wo.wrap = not vim.wo.wrap<CR>', opts_desc 'toggle wrap')
keymap('n', '<leader>tn', '<cmd>lua vim.o.number = not vim.wo.number<CR>', opts_desc 'toggle display linenumber')
keymap('n', '<leader>trn', '<cmd>lua vim.o.relativenumber = not vim.wo.number<CR>', opts_desc 'toggle display linenumber')
-- keymap('n', 'leader>tc', '<cmd>lua vim.wo.conceallevel = vim.wo.conceallevel == 2 and 0 or 2<CR>', opts_desc 'toggle conceal')
-- keymap('n', 'leader>tH', '<cmd>lua vim.o.cmdheight = vim.o.cmdheight == 0 and 1 or 0<CR>', opts_desc 'toggle cmdheight')

-- Clear highlights on search when pressing <Esc> in normal mode
keymap('n', '<esc>', '<cmd>nohlsearch<CR>', opts_desc 'clear search highlight')

-- Diagnostic keymaps
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

keymap('n', '<leader>cd.', [[:cd %:h|pwd<cr>]], opts_desc("change CWD to current file's directory", no_silent))
keymap('n', '<leader>cd..', [[:cd ..|pwd<cr>]], opts_desc('change CWD to parent directory of current file', no_silent))

-- Keybinds to make split navigation easier. (Use CTRL+<hjkl> to switch between windows)
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- keymap('', [[\]], [[<localleader>]], {})

----------- Cursor movement
-- Disable arrow keys in normal mode
-- vim.keymap.set('', '<left>', '')
-- vim.keymap.set('', '<right>', '')
-- vim.keymap.set('', '<up>', '')
-- vim.keymap.set('', '<down>', '')

keymap('i', '<C-b>', '<Left>', opts)
keymap('i', '<C-f>', '<Right>', opts)
keymap('i', '<C-a>', '<home>', opts)
keymap('i', '<C-h>', '<BS>', opts)
keymap('i', '<C-d>', '<Del>', opts)
keymap('i', '<C-k>', '<C-o>D', opts)
-- NOTE: cannot use { silent = true } here, the reason is unknown.
keymap('c', '<C-b>', '<Left>', { noremap = true })
keymap('c', '<C-f>', '<Right>', { noremap = true })
keymap('c', '<C-a>', '<home>', { noremap = true })
keymap('c', '<C-e>', '<end>', { noremap = true })
keymap('c', '<C-h>', '<BS>', { noremap = true })
keymap('c', '<C-d>', '<Del>', { noremap = true })
-- do the same as <C-k> in insert mode is a bit complex in cmdline mode.
keymap('c', '<C-k>', [[<C-\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<CR>]], { noremap = true })
keymap('c', '<A-b>', '<S-Left>', { noremap = true })
keymap('c', '<A-f>', '<S-Right>', { noremap = true })

-- keymap('i', '<A-c><A-c>', '<C-x><C-]>', opts_desc 'Tag completion')
-- keymap('i', '<A-c><A-f>', '<C-x><C-f>', opts_desc 'File completion')
-- keymap('i', '<A-c><A-d>', '<C-n>', opts_desc 'Document completion')

-- keymap('i', '<C-x><C-x>', '<C-x><C-]>', opts_desc 'Tag completion')
-- keymap('i', '<C-x><C-d>', '<C-n>', opts_desc 'Document completion')

-----

-- see `:h pumvisible()`
keymap('i', '<C-e>', [[pumvisible() ? '<C-e>' : '<end>']], {
  desc = 'go to line end or abort completion when pum is visible',
  noremap = true,
  expr = true,
})
keymap('i', '<C-n>', [[pumvisible() ? '<C-n>' : '<down>']], {
  desc = 'Go to next line',
  noremap = true,
  expr = true,
})
keymap('i', '<C-p>', [[pumvisible() ? '<C-p>' : '<up>']], {
  desc = 'Go to previous line',
  noremap = true,
  expr = true,
})

----------- Disable stuff
-- <C-g> by default echos the current file name, which is useless. Disable it
keymap('n', '<C-g>', '<ESC>', {})

-- middle mouse button
keymap('', [[<MiddleMouse>]], [[<nop>]], {})

--
local jk_as_esc_f = function()
  -- Don't set up jk escape if completion menu is visible
  if vim.fn.pumvisible() == 1 then
    return 'j'
  end

  keymap('t', 'k', [[]], {
    noremap = true,
    expr = true,
    callback = function()
      -- some terminal program may want to use different "undo" escape sequence,
      -- for example we want to use `k<C-\><C-N>` as "undo" escape
      -- sequence for lazygit.
      -- In expr mapping, the special key sequence are not interpreted,
      -- we need to input the ascii code of those special key sequence
      -- directly. The default is <BS><C-\><C-N>
      return vim.b[0].jk_esc_undo_sequence or '\x08\x1c\x0E'
    end,
  })
  keymap('i', 'k', [[<BS><ESC>]], opts)
  vim.defer_fn(function()
    pcall(vim.keymap.del, 't', 'k')
    pcall(vim.keymap.del, 'i', 'k')
  end, 250)
  return 'j'
end

local jk_as_esc = {
  noremap = true,
  desc = 'enter jk as esc mode',
  callback = jk_as_esc_f,
  expr = true,
}
keymap('i', 'j', '', jk_as_esc)
keymap('t', 'j', '', jk_as_esc)
keymap('v', 'j', '', jk_as_esc)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local my_augroup = augroup('MyAugroup', {})

autocmd('TextYankPost', {
  group = my_augroup,
  callback = function()
    vim.hl.on_yank { higroup = 'IncSearch', timeout = 400 }
  end,
  desc = 'highlight yanked text',
})
