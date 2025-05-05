-- UI
vim.wo.number = true -- Make line numbers default
vim.o.relativenumber = true -- Set relative numbered lines
vim.o.wrap = false -- Display lines as one long line
vim.o.linebreak = true -- Don't split words
vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.termguicolors = true
vim.o.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8 -- Minimal number of screen columns either side of cursor if wrap is `false`
vim.o.cmdheight = 1
vim.o.cursorline = true

-- Split window
vim.o.splitbelow = true
vim.o.splitright = true

-- Functions
vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.backspace = 'indent,eol,start'

-- Search / case
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true -- Smart case

-- Indentation
vim.o.autoindent = true -- Copy indent from current line when starting new one
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  command = 'setlocal autoindent shiftwidth=2 tabstop=2 softtabstop=2 expandtab smartindent breakindent',
})

-- Disable auto commenting on new line
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
  desc = 'Disable New Line Comment',
})
