require('trouble').setup({
  -- configure modes
  modes = {
    diagnostics = {
      -- automatically open the list when you have diagnostics
      auto_open = true,
    },
    -- you can add other modes here if needed
    -- another_mode = {
    --   auto_open = true, -- example for another mode
    -- }
  },
  -- automatically close the list when you have no diagnostics
  auto_close = true,
  -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_preview = true,
  -- automatically fold a file trouble list at creation
  auto_fold = true,
  -- you can keep other existing configurations here
})
