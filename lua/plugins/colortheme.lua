-- [[ Colorscheme ]]
return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  config = true,
  opts = {
    contrast = 'hard',
    transparent_mode = false,
  },
  init = function()
    vim.cmd 'colorscheme gruvbox'
  end,
}
