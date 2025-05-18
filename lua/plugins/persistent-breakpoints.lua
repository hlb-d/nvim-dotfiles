return {
  'Weissle/persistent-breakpoints.nvim',
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    require('persistent-breakpoints').setup {
      load_breakpoints_event = { 'BufReadPost' }, -- recommended
      save_dir = vim.fn.stdpath 'data' .. '/nvim_checkpoints', -- optional: customize save path
      -- perf_record = false, -- optional: enable performance tracking
      -- on_load_breakpoint = function(opts, buf_id, line)
      --   -- optional: callback when a breakpoint is loaded
      -- end,
      always_reload = true, -- optional: useful with session plugins
    }
    vim.api.nvim_create_autocmd('BufWritePost', {
      callback = function()
        require('persistent-breakpoints.api').store_breakpoints()
      end,
    })
  end,
}
