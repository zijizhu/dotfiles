-- A user command to open a new buffer with a specified filetype
vim.api.nvim_create_user_command('EnewFt', function(opts)
  -- opts.args contains the arguments passed to the command
  -- In this case, we expect one argument for the filetype
  local filetype = opts.args

  if filetype == nil or filetype == '' then
    print("Usage: :EnwFt <filetype>")
    return
  end

  -- Execute the Vim commands
  vim.cmd('enew')
  vim.cmd('setlocal filetype=' .. filetype)

  print("Opened new buffer with filetype: " .. filetype)
end, {
  -- Options for the user command
  nargs = 1, -- Expect exactly one argument
  complete = "filetype", -- Enable filetype completion for the argument
  desc = "Open a new buffer and set its filetype", -- Description for :h :commands
})
